require 'rails_helper'
require 'faker'

RSpec.describe User, type: :model do
  describe 'ユーザー新規登録' do
    before do
      @user = FactoryBot.build(:user)
    end

    context '新規登録できる時' do
      it '全ての値が正しく入力されていれば保存できる' do
        expect(@user).to be_valid
      end

      it 'emailが@を含めば登録できる' do
        @user.email = 'test@test.com'
        expect(@user).to be_valid
      end

      it 'nicknameが10文字以下なら登録できる' do
        @user.nickname = 'testtestte'
        expect(@user).to be_valid
      end

      it 'passwordとpassword_confirmationが6文字以上であれば登録できる' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        expect(@user).to be_valid
      end
    end


    context '新規登録できない時' do
      it 'ニックネームが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it 'メールアドレスが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it 'メールアドレスが正しくない場合は登録できない' do
        @user.email = 'testexample.com'
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end

      it '重複したメールアドレスの場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email=@user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Email has already been taken")
      end

      it 'emailが@を含まないと登録できない' do
        @user.email='testtest.com'
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end

      it 'パスワードが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it 'パスワードが5文字以下では登録できない' do
        @user.password = '12345'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end

      it 'パスワードとパスワード確認が一致しないと登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '345678'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it '姓が空では登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end

      it '姓に半角文字が含まれる場合は登録できない' do
        @user.last_name = 'Yamada' # 全角文字に修正
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name is invalid")
      end

      it '名が空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end

      it '名に半角文字が含まれる場合は登録できない' do
        @user.first_name = 'Taro' # 全角文字に修正
        @user.valid?
        expect(@user.errors.full_messages).to include("First name is invalid")
      end

      it '姓のフリガナが空では登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end

      it '姓のフリガナにカタカナ以外の文字が含まれる場合は登録できない' do
        @user.last_name_kana = 'やまだ'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana is invalid")
      end

      it '名のフリガナが空では登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end

      it '名のフリガナにカタカナ以外の文字が含まれる場合は登録できない' do
        @user.first_name_kana = 'たろう'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana is invalid")
      end

      it '誕生日が空では登録できない' do
        @user.birth_date = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth date can't be blank")
      end

    end
  end
end