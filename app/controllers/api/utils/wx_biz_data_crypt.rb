# frozen_string_literal: true

require 'openssl'
require 'base64'
require 'json'

module API
  module Utils
    class WxBizDataCrypt
      attr_accessor :session_key, :app_id

      def initialize(app_id, session_key)
        @app_id = app_id
        @session_key = session_key
      end

      def decrypt(encrypted_data, iv)
        ase_key = Base64.decode64(@session_key)
        aes_iv = Base64.decode64(iv)
        aes_cipher = Base64.decode64(encrypted_data)
        cipher = build_decrypt_cipher(aes_iv, ase_key)
        decrypted = cipher.update(aes_cipher) + cipher.final
        JSON.parse decrypted[0..-(decrypted.last.ord + 1)]
      end

      private

      def build_decrypt_cipher(iv, session_key)
        OpenSSL::Cipher.new('AES-128-CBC').tap do |cipher|
          cipher.decrypt
          cipher.key = session_key
          cipher.iv = iv
          cipher.padding = 0
        end
      end
    end
  end
end
