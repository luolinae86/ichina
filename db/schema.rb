# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_04_07_142739) do

  create_table "complaints", id: :string, limit: 36, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "topic_id"
    t.string "complaint_type", limit: 20, comment: "被投诉的类型(:违法违禁 :色情低俗, :攻击谩骂, :营销广告, :青少年不良信息"
    t.string "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "customers", id: :string, limit: 36, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "nick_name", limit: 50
    t.string "phone", limit: 20
    t.string "address", limit: 50
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "uuid", limit: 36
    t.string "head_url"
    t.string "openid", limit: 50
    t.string "social_account", comment: "用户发贴用的社交帐号"
    t.string "pc_id", limit: 40, comment: "PC端的用户ID"
    t.integer "tel_type", default: 0, comment: "社交账号类型"
    t.string "user_name", limit: 50, comment: "用户名"
    t.string "postcodes", limit: 20, comment: "邮编"
    t.string "user_pwd", limit: 50, comment: "用户状态"
  end

  create_table "topics", id: :string, limit: 36, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "customer_id"
    t.string "topic_type", limit: 20, comment: "帖子类型：need_help(需要帮助):provide_help(提供帮助):report_safe(报平安)"
    t.string "content"
    t.integer "viewed_count", default: 0, comment: "被查看了多少次"
    t.string "status", default: "published", comment: "状态：published(发布):done(完成)"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "latitude", limit: 40
    t.string "longitude", limit: 40
    t.string "uuid", limit: 32
    t.boolean "is_urgent", default: false
    t.string "parent_id", limit: 32, comment: "关联帖子ID"
    t.integer "up_count", default: 0, comment: "点赞次数"
    t.integer "down_count", default: 0, comment: "被踩次数"
    t.index ["customer_id"], name: "index_topics_on_customer_id"
    t.index ["uuid"], name: "index_topics_on_uuid"
  end

  create_table "users", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "uuid", limit: 8
    t.string "name", limit: 10
    t.string "phone", limit: 11
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_users_on_name"
    t.index ["phone"], name: "index_users_on_phone"
  end

end
