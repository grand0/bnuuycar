package ru.kpfu.itis.gr201.ponomarev.springcars.util;

import com.cloudinary.Cloudinary;
import com.cloudinary.Transformation;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.Part;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;

public class CloudinaryUtil {
    private static Cloudinary cloudinary;

    public static Cloudinary getInstance() {
        if (cloudinary == null) {
            Map<String, String> configMap = new HashMap<>();
            configMap.put("cloud_name", "ddnshpyyd");
            configMap.put("api_key", "349574773469126");
            configMap.put("api_secret", System.getenv("CloudinaryBuycarSecret"));
            cloudinary = new Cloudinary(configMap);
        }
        return cloudinary;
    }

    public static String getRoundCroppedImageUrl(String url) {
        return getInstance().url().type("fetch").transformation(
                new Transformation()
                        .aspectRatio("1:1")
                        .gravity("auto")
                        .radius("max")
                        .width(150)
                        .crop("fill")
                        .fetchFormat("png")
        ).generate(url);
    }

    public static String uploadPart(InputStream in) throws IOException {
        File dir = new File("\\tmp");
        dir.mkdirs();
        File file = File.createTempFile("bcar", null, dir);
        file.deleteOnExit();
        try (
                FileOutputStream out = new FileOutputStream(file)
        ) {
            byte[] buffer = new byte[5120];
            while (in.available() != 0) {
                int size = in.read(buffer);
                out.write(buffer, 0, size);
            }
        }
        Cloudinary cloudinary = CloudinaryUtil.getInstance();
        Map<String, Object> uploadResponse = cloudinary.uploader().upload(file, new HashMap<>());
        return (String) uploadResponse.get("url");
    }
}
