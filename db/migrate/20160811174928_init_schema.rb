class InitSchema < ActiveRecord::Migration
  def up
    
    # These are extensions that must be enabled in order to support this database
    enable_extension "plpgsql"
    
    create_table "contact_forms", force: :cascade do |t|
      t.integer  "page_id"
      t.integer  "user_id"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "title"
    end
    
    add_index "contact_forms", ["page_id"], name: "index_contact_forms_on_page_id", using: :btree
    add_index "contact_forms", ["user_id"], name: "index_contact_forms_on_user_id", using: :btree
    
    create_table "events", force: :cascade do |t|
      t.string   "title_sv"
      t.string   "description_sv"
      t.datetime "start_time"
      t.datetime "end_time"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "event_group_id"
      t.string   "title_en"
      t.string   "description_en"
    end
    
    add_index "events", ["event_group_id"], name: "index_events_on_event_group_id", using: :btree
    
    create_table "images", force: :cascade do |t|
      t.string   "image_uid"
      t.string   "image_name"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "title"
    end
    
    create_table "nav_items", force: :cascade do |t|
      t.string   "title_sv"
      t.integer  "page_id"
      t.integer  "parent_id"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "title_en"
      t.integer  "position"
      t.integer  "nav_item_type", default: 0, null: false
      t.string   "link"
    end
    
    add_index "nav_items", ["page_id"], name: "index_nav_items_on_page_id", using: :btree
    add_index "nav_items", ["parent_id"], name: "index_nav_items_on_parent_id", using: :btree
    
    create_table "pages", force: :cascade do |t|
      t.string   "title_sv"
      t.text     "content_sv"
      t.string   "slug"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "title_en"
      t.text     "content_en"
      t.integer  "image_id"
    end
    
    add_index "pages", ["image_id"], name: "index_pages_on_image_id", using: :btree
    
    create_table "pages_users", force: :cascade do |t|
      t.integer  "page_id"
      t.integer  "user_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
    
    add_index "pages_users", ["page_id"], name: "index_pages_users_on_page_id", using: :btree
    add_index "pages_users", ["user_id"], name: "index_pages_users_on_user_id", using: :btree
    
    create_table "posts", force: :cascade do |t|
      t.string   "title_sv"
      t.text     "content_sv"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "title_en"
      t.text     "content_en"
      t.integer  "image_id"
    end
    
    add_index "posts", ["image_id"], name: "index_posts_on_image_id", using: :btree
    
    create_table "questions", force: :cascade do |t|
      t.string   "content"
      t.integer  "contact_form_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
    
    add_index "questions", ["contact_form_id"], name: "index_questions_on_contact_form_id", using: :btree
    
    create_table "settings", force: :cascade do |t|
      t.string   "var",                   null: false
      t.text     "value"
      t.integer  "thing_id"
      t.string   "thing_type", limit: 30
      t.datetime "created_at"
      t.datetime "updated_at"
    end
    
    add_index "settings", ["thing_type", "thing_id", "var"], name: "index_settings_on_thing_type_and_thing_id_and_var", unique: true, using: :btree
    
    create_table "taggings", force: :cascade do |t|
      t.integer  "taggable_id"
      t.string   "taggable_type"
      t.integer  "tag_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
    
    add_index "taggings", ["tag_id", "taggable_type"], name: "index_taggings_on_tag_id_and_taggable_type", using: :btree
    add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
    
    create_table "tags", force: :cascade do |t|
      t.string   "title"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "color"
    end
    
    create_table "trigrams", force: :cascade do |t|
      t.string  "trigram",     limit: 3
      t.integer "score",       limit: 2
      t.integer "owner_id"
      t.string  "owner_type"
      t.string  "fuzzy_field"
    end
    
    add_index "trigrams", ["owner_id", "owner_type", "fuzzy_field", "trigram", "score"], name: "index_for_match", using: :btree
    add_index "trigrams", ["owner_id", "owner_type"], name: "index_by_owner", using: :btree
    
    create_table "uploads", force: :cascade do |t|
      t.string   "file_name"
      t.string   "file_uid",   null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
    
    create_table "users", force: :cascade do |t|
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "email",                   default: "", null: false
      t.string   "encrypted_password",      default: "", null: false
      t.string   "reset_password_token"
      t.datetime "reset_password_sent_at"
      t.datetime "remember_created_at"
      t.integer  "sign_in_count",           default: 0,  null: false
      t.datetime "current_sign_in_at"
      t.datetime "last_sign_in_at"
      t.string   "current_sign_in_ip"
      t.string   "last_sign_in_ip"
      t.string   "name"
      t.string   "phonenumber"
      t.string   "title_sv"
      t.integer  "role"
      t.string   "title_en"
      t.integer  "locale"
      t.string   "profile_image_uid"
      t.string   "profile_image_thumb_uid"
    end
    
    add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
    add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    
  end

  def down
    raise ActiveRecord::IrreversibleMigration, "The initial migration is not revertable"
  end
end
