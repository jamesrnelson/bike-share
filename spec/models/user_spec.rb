require "rails_helper"

describe User, type: :model do
  describe "validations" do
    it "is invalid without a username" do
      user = User.new(password: "pass", name: "name")

      expect(user).to be_invalid
    end

    it "is invalid if username not unique" do
      legit_user = User.create(username: "user", password: "pass", name: "name")
      invalid_user = User.new(username: "user", password: "pass", name: "name")

      expect(invalid_user).to_not be_valid
    end
  end

  describe "status" do
    it "can be an admin" do
      admin = User.create!(username: "user", password: "pass", status: "admin", name: "name")

      expect(admin.status).to eq("admin")
    end

    it "can be a default user" do
      reg_user = User.create!(username: "user", password: "pass", name: "name")

      expect(reg_user.status).to eq("default")
    end
  end
end
