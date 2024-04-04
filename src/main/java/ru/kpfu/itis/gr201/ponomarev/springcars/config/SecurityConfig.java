package ru.kpfu.itis.gr201.ponomarev.springcars.config;

import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.password.MessageDigestPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import ru.kpfu.itis.gr201.ponomarev.springcars.security.CustomUserDetailsService;

@Configuration
@EnableWebSecurity
@ComponentScan("ru.kpfu.itis.gr201.ponomarev.springcars.security")
@RequiredArgsConstructor
public class SecurityConfig extends WebSecurityConfigurerAdapter {

    private final CustomUserDetailsService userDetailsService;

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http
                .authorizeRequests()
                    .antMatchers("/").permitAll()
                    .antMatchers("/auth", "/register").permitAll()
                    .antMatchers("/profile").authenticated()
                .and().csrf()
                    .disable()
                .formLogin()
                    .loginPage("/auth")
                    .loginProcessingUrl("/auth")
                    .usernameParameter("login")
                    .passwordParameter("password")
                    .failureHandler((req, resp, ex) -> {
                        ex.printStackTrace(System.err);
                        resp.setContentType("application/json");
                        resp.getWriter().write("{\"success\":0,\"unauthorized\":1}");
                    })
                    .successHandler((req, resp, auth) -> {
                        resp.setContentType("application/json");
                        resp.getWriter().write("{\"success\":1}");
                    })
                .and().rememberMe()
                    .key("bnuuycar-key")
                    .rememberMeParameter("remember")
                    .userDetailsService(userDetailsService)
                .and().logout()
                    .logoutUrl("/logout")
                    .logoutSuccessUrl("/")
                .and().exceptionHandling()
                    .accessDeniedHandler((req, resp, ex) -> resp.sendRedirect("/"));
    }

    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.authenticationProvider(authenticationProvider())
                .userDetailsService(userDetailsService);
    }

    @Bean
    public AuthenticationProvider authenticationProvider() {
        DaoAuthenticationProvider provider = new DaoAuthenticationProvider();
        provider.setUserDetailsService(userDetailsService);
        provider.setPasswordEncoder(passwordEncoder());
        return provider;
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new MessageDigestPasswordEncoder("MD5");
    }
}
