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

ActiveRecord::Schema.define(version: 2019_10_22_111502) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "tree_nodes", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "ancestry"
    t.integer "external_id"
    t.bigint "parent_id"
    t.index ["ancestry"], name: "index_tree_nodes_on_ancestry"
    t.index ["parent_id"], name: "index_tree_nodes_on_parent_id"
  end

  add_foreign_key "tree_nodes", "tree_nodes", column: "parent_id"
end
