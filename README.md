# Apartment Bug with Rails 8.1

This repository demonstrates a bug that occurs when running `rails db:migrate` on a Rails 8.1 application using the `apartment` gem and `postgresql`.

## The Issue

When running `rails db:migrate` in Rails 8.1, the `db/schema.rb` file is updated such that table names are prefixed with `public.` (e.g., `create_table "public.users"` instead of `create_table "users"`). This change causes `apartment` to skip creating the appropriate tables in tenant schema.

## Suspected Cause

This behavior seems to be related to changes introduced in Rails PR #50020: [https://github.com/rails/rails/pull/50020](https://github.com/rails/rails/pull/50020).

## Demonstration

I've setup a simple test case in the file [./test/models/customer_test.rb](./test/models/customer_test.rb) that illustrates the issue. When you run the test, it fails because the `customers` table is not created in the tenant schema.

> Note: I've also setup a GitHub CodeSpace for easy reproduction.


```bash
rails test test/models/customer_test.rb
```

Alternatively, you can create a new `Customer` record in the Rails console:

```ruby
Customer.create(name: "Test Customer")
```

Which will raise the following error:

```
app/models/customer.rb:14:in 'Customer#default_data': PG::UndefinedTable: ERROR:  relation "buildings" does not exist (ActiveRecord::StatementInvalid)
LINE 10:  WHERE a.attrelid = '"buildings"'::regclass
```
