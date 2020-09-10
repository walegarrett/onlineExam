package com.wale.exam.config;

import org.springframework.web.servlet.view.InternalResourceView;

import java.io.File;
import java.util.Locale;

/**
 * @Author WaleGarrett
 * @Date 2020/8/12 21:30
 */
public class AdminResourceView extends InternalResourceView {
    @Override
    public boolean checkResource(Locale locale){
        File file = new File(this.getServletContext().getRealPath("/")+getUrl());
        return file.exists();
    }
}
