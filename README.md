What's ?
===============
chef で使用する kibana の cookbook です。

Usage
-----
cookbook なので berkshelf で取ってきて使いましょう。

* Berksfile
```ruby
source "https://supermarket.chef.io"

cookbook "kibana", git: "https://github.com/bageljp/cookbook-kibana.git"
```

```
berks vendor
```

#### Role and Environment attributes

* sample_role.rb
```ruby
override_attributes(
  "kibana" => {
    "link_dir" => "/var/www/html",
    "elasticsearch" => {
      "uri" => "http://insert-to-global-ip/elasticsearch"
    }
  }
)
```

Recipes
----------

#### kibana::default
kibana のインストールと設定。

#### kibana::default
ElasticSearch のインデックスに kibana から参照しやすいよう dynamicテンプレート の設定を行う。  
なお ``files/default/kibana_template.json`` はサンプルなので実際収集するログに合わせて定義してください。

Attributes
----------

主要なやつのみ。

#### mariadb::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
  </tr>
  <tr>
    <td><tt>['kibana']['elasticsearch']['uri']</tt></td>
    <td>string</td>
    <td>kibana で参照する ElasticSearch のURI。</td>
  </tr>
</table>

