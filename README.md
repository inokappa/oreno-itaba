## 俺の板場

### はじめに

- itamae の私的なチュートリアル

### 使い方

- bundle install

```
bundle install
```

- kitchen init

```
kitchen init --driver=kitchen-docker --provisioner=itamae
```

- kitchen crate

```
kitchen crate
```

- kitchen converge / kitchen verify

```
kitchen converge
kithcen verify
```

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
