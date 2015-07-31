## 俺の板場

### はじめに

- itamae の私的なチュートリアル
- itamae で簡単なレシピを書いて test-kitchen で流して Serverspec でテストするまで

### 参考

- http://qiita.com/sawanoboly/items/7cf323e65a4757321553
- http://qiita.com/Marcy/items/7ca000f83d08266ee352
- http://qiita.com/riocampos/items/0df10dd7956ce9de0ffb

### 使い方

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

### ハマったところ

- 検証環境（MacOS X 10.10）の Ruby バージョンが古かったので ruby-build を更新して `rbenv install 2.2.2` でRuby を更新

### ファイル構成

```
.
├── Gemfile
├── Gemfile.lock
├── README.md
├── chefignore
├── kitchen
│   ├── cookbooks
│   │   ├── httpd
│   │   │   └── default.rb
│   │   ├── nginx
│   │   │   └── default.rb
│   │   └── sl
│   │       └── default.rb
│   └── roles
│       └── web.rb
└── test
    └── integration
        └── default
            └── serverspec
                └── httpd_spec.rb

10 directories, 9 files
```

### todo

- makanai という名前のツールを作る
