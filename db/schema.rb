# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160404222851) do

  create_table "clientes", force: true do |t|
    t.string   "nome"
    t.string   "endereco"
    t.string   "telefone"
    t.date     "dataNascimento"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "clientes", ["email"], name: "index_clientes_on_email", unique: true
  add_index "clientes", ["reset_password_token"], name: "index_clientes_on_reset_password_token", unique: true

  create_table "contas", force: true do |t|
    t.string   "descricao"
    t.string   "codigo"
    t.integer  "cliente_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "ativa",      default: true
  end

  create_table "movimentacoes", force: true do |t|
    t.string   "tipo",                        null: false
    t.float    "valor"
    t.integer  "conta_orig_id"
    t.integer  "conta_dest_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "taxa",          default: 0.0, null: false
  end

end
