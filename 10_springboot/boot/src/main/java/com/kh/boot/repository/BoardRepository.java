package com.kh.boot.repository;

import com.kh.boot.domain.entity.Board;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
@Transactional
public interface BoardRepository extends JpaRepository<Board, String > {

}
