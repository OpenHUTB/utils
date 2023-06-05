classdef AES < handle
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
	% 参考：https://ww2.mathworks.cn/matlabcentral/fileexchange/73037-matlab-aes-encryption-decryption-example
    
    properties (Access = private)
        secretKey
        cipher
    end
    
    methods
        function obj = AES(secret, algorithm)
            %AES Construct an instance of this class
            %   algorithm options are https://docs.oracle.com/javase/9/docs/specs/security/standard-names.html#messagedigest-algorithms
            import java.security.MessageDigest;
            import java.lang.String;
            import java.util.Arrays;
            import javax.crypto.Cipher;
            
            key = String(secret).getBytes("UTF-8");
            sha = MessageDigest.getInstance(algorithm);
            key = sha.digest(key);
            key = Arrays.copyOf(key, 16);
            obj.secretKey = javaObject('javax.crypto.spec.SecretKeySpec',key, "AES");
            obj.cipher = Cipher.getInstance("AES/ECB/PKCS5Padding");
        end
        
        function encrypted = encrypt(obj, strToEncrypt)
            %ENCRYPT Summary of this method goes here
            %   Detailed explanation goes here           
            import java.util.Base64;
            import java.lang.String;
            import javax.crypto.Cipher;
            
            obj.cipher.init(Cipher.ENCRYPT_MODE, obj.secretKey);
            encrypted = string(Base64.getEncoder().encodeToString(obj.cipher.doFinal(String(strToEncrypt).getBytes("UTF-8"))));
        end
        
        function encrypted = encryptStructuredData(obj, structuredData)
            encrypted = obj.encrypt(jsonencode(structuredData));
        end
        
        function decrypted = decryptStructuredData(obj, encryptedStructuredData)
            decrypted = jsondecode(obj.decrypt(encryptedStructuredData));
        end        
        
        function decrypted = decrypt(obj, strToDecrypt)
            %DECRYPT Summary of this method goes here
            %   Detailed explanation goes here
            import javax.crypto.Cipher;
            import java.lang.String;
            import java.util.Base64;
            
            obj.cipher.init(Cipher.DECRYPT_MODE, obj.secretKey);
            decrypted = string(String(obj.cipher.doFinal(Base64.getDecoder().decode(strToDecrypt))));
        end
    end
end

