package com.example.springboot;

import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.RequestMapping;

@RestController
public class HelloController {

	@RequestMapping("/")
	public String index() {
		String hostname = System.getenv("HOSTNAME");
        String myvar = System.getenv("MY_VAR");
		return "Greetings from Spring Boot @FiiPractic! Hostname is: " + hostname + ". MY_VAR is " + myvar + ".";
	}

}
