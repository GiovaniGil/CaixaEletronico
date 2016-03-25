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

ActiveRecord::Schema.define(version: 20160323143050) do

  create_table "clientes", force: true do |t|
    t.string   "nome"
    t.string   "endereco"
    t.string   "telefone"
    t.date     "dataNascimento"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contas", force: true do |t|
    t.string   "descricao"
    t.string   "codigo"
    t.integer  "cliente_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "movimentacoes", force: true do |t|
    t.string   "tipo",          null: false
    t.float    "valor"
    t.integer  "conta_orig_id"
    t.integer  "conta_dest_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
