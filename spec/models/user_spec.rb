require "rails_helper"

describe User, type: :model do
  describe "validations" do
    it "is invalid without a username" do
      user = User.new(password: "pass")

      expect(user).to be_invalid
    end

    it "is invalid if username not unique" do
      legit_user = User.create(username: "user", password: "pass")
      invalid_user = User.new(username: "user", password: "pass")

      expect(invalid_user).to_not be_valid
    end
  end

  describe "roles" do
    it "can be an admin" do
      admin = User.create!(username: "user", password: "pass", role: "admin")

      expect(admin.admin?).to be_truthy
      expect(admin.role).to eq("admin")
    end

    it "can be a default user" do
      reg_user = User.create!(username: "user", password: "pass")

      expect(reg_user.default?).to be_truthy
      expect(reg_user.role).to eq("default")
    end
  end
end
