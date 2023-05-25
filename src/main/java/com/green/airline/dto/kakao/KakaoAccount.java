
package com.green.airline.dto.kakao;

import javax.annotation.Generated;

import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import com.fasterxml.jackson.databind.annotation.JsonNaming;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Generated("jsonschema2pojo")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@JsonNaming(value = PropertyNamingStrategies.SnakeCaseStrategy.class)
public class KakaoAccount {

    public Boolean profileNicknameNeedsAgreement;
    public Profile profile;
    public Boolean hasEmail;
    public Boolean emailNeedsAgreement;
    public Boolean isEmailValid;
    public Boolean isEmailVerified;
    public String email;
    public Boolean hasGender;
    public Boolean genderNeedsAgreement;
    public String gender;

}
