package com.kh.boot.domain.entity;

//ORM ： 어플리케이션의 객체를 RDB 테이블에 자동으로 영속성을 갖게 해주는 것
//JPA : java에서 ORM을 위한 표준 인터페이스 및 규약을 정의한 API다.
//Hibernate : Java언어로 작성된 객체 관계 매핑(Object-Relational-Mapping, ORM) 프레임워크
//sql쿼리를 직접 작성하지 않고도 데이터베이스 연산을 수행할 수 있도록 도와줌

//@Data : getter, setter, toString, equals, hashCode
//@Entity : 해당 클래스가 데이터베이스의 테이블과 매핑되는 엔티티클래스임을 나타낸다. -> 테이블로 변환된다.

import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import java.time.LocalDateTime;

@Table(name = "BOARD")
@Entity
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Builder
@AllArgsConstructor
@Data
public class Board {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY) //기본키가 자동으로 증가하는 방식을 이용한다.
    @Column(unique = true)
    private Long boardId;

    @Column(nullable = false, length = 100)
    private String title;

    @Column(columnDefinition = "TEXT") //해당 컬럼은 TEXT타입으로 명시, 일반적으로 생성시 varchar(255)
    private String contents;

    @Column(length = 30)
    private String userId;

    @Column(nullable = true, length = 255)
    private String fileName;

    @Column(nullable = false, length = 100)
    private String pwd;

    @CreationTimestamp //엔티티가 처음으로 생성될 때 타임스탬프를 자동으로 설정
    @Column
    private LocalDateTime createAt;

    @UpdateTimestamp //엔티티가 업데이트 될때마다 타임스탬프를 자동으로 설정
    @Column
    private LocalDateTime updateAt;

//    private Board(){}
//
//    public static Builder builder(){
//        return new Builder();
//    }
//
//    public static class Builder{
//        private Board board = new Board();
//
//        public Builder setBoardId(String userId){
//            this.board.setUserId(userId);
//            return this;
//        }
//
//        public Builder setBoardPwd(String pwd){
//            this.board.setPwd(pwd);
//            return this;
//        }
//
//        public Board build(){
//            return board;
//        }
//
//    }
}