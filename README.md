## 俺の板場
[![wercker status](https://app.wercker.com/status/0ee282a57bb460a915b227bde1ad6be2/s/master "wercker status")](https://app.wercker.com/project/bykey/0ee282a57bb460a915b227bde1ad6be2)

***

### はじめに

- itamae の私的なチュートリアル
- itamae で簡単なレシピを書いて test-kitchen で流して Serverspec でテストするまで

***

### 参考

- https://github.com/itamae-kitchen/itamae/wiki
- http://qiita.com/sawanoboly/items/7cf323e65a4757321553
- http://qiita.com/Marcy/items/7ca000f83d08266ee352
- http://qiita.com/riocampos/items/0df10dd7956ce9de0ffb
- http://gihyo.jp/admin/serial/01/itamae

***

### test-kitchen 周りの使い方

- bundle install

```
bundle install
```

- kitchen init

```
kitchen init --driver=kitchen-docker --provisioner=itamae
```

- .kitchen.local.yml の作成 

```
---
driver:
  name: docker

provisioner:
  name: itamae

platforms:
  - name: centos-6
    driver_config:
      image: centos:centos6

suites:
  - name: default
    run_list:
      - cookbooks/httpd/default.rb
```

- kitchen create

```
kitchen create
```

- kitchen converge / kitchen verify

```
kitchen converge
kithcen verify
```

***

### itamae の使い方

- Docker バックエンド

```sh
itamae docker file/default.rb --container ${container_name} --log-level=debug --dry-run
itamae docker file/default.rb --container ${container_name} --log-level=debug 
```

- SSH バックエンド

```sh
itamae ssh --user=user --ask-password file/default.rb --host=127.0.0.1 --port=22 --log-level=debug --dry-run
itamae ssh --user=user --ask-password file/default.rb --host=127.0.0.1 --port=22 --log-level=debug
```

- SSH バックエンドで role でレシピを指定

```sh
itamae ssh --user=user --ask-password kitchen/roles/web.rb --host=xxx.xxx.xxx.xxx --port=22 --log-level=info --dry-run
itamae ssh --user=user --ask-password kitchen/roles/web.rb --host=xxx.xxx.xxx.xxx --port=22 --log-level=info
```

***

### itamae のレシピの書き方

#### 基本

- wiki を読む

#### OS 毎の処理

- 多分 Specinfra が由なに計らってくれるので以下のような書き方が出来る

```ruby
case node[:platform]
when "ubuntu", "debian"
  package "apache2"
  service "apache2" do
    action [ :start, :enable ]
  end
when "centos", "redhat", "amazon"
  package "httpd"
  service "httpd" do
    action [ :start, :enable ]
  end
end
```

***

### Serverspec の tips

#### OS 毎の処理

- http://serverspec.org/advanced_tips.html

```ruby
if os[:family] == 'redhat'

  describe package("httpd") do
    it { should be_installed }
  end
  
  describe service("httpd") do
    it { should be_enabled }
    it { should be_running }
  end

elsif ['debian', 'ubuntu'].include?(os[:family])

  describe package("apache2") do
    it { should be_installed }
  end

  describe service("apache2") do
    it { should be_enabled }
    it { should be_running }
  end

end
```

### ハマったところとか

- 検証環境（MacOS X 10.10）の Ruby バージョンが古かったので ruby-build を更新して `rbenv install 2.2.2` でRuby を更新
- spec ファイルの置き場は `test/integration/default/serverspec/*_spec.rb` にレシピ毎に置く
- Docker backend を利用する場合には [file リソース](https://github.com/itamae-kitchen/itamae/wiki/file-resource)で `edit` アクション、`content` リソースが利用出来ない（要調査）

### ファイル構成

```
.
├── Gemfile
├── Gemfile.lock
├── README.md
├── chefignore
├── dockerfiles
│   ├── centos
│   │   └── Dockerfile
│   └── ubuntu
│       └── Dockerfile
├── kitchen
│   ├── recipes
│   │   ├── file
│   │   │   └── default.rb
│   │   ├── httpd
│   │   │   └── default.rb
│   │   ├── nginx
│   │   │   └── default.rb
│   │   └── sl
│   │       └── default.rb
│   └── roles
│       └── web.rb
├── test
│   └── integration
│       └── default
│           └── serverspec
│               ├── file_spec.rb
│               └── httpd_spec.rb
└── wercker.yml

14 directories, 14 files
```

### todo

- 引き続き itamae を触ってみる
- wercker で無駄に CI をしてみる
- makanai という名前のツールを作る
