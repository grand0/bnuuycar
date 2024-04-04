package ru.kpfu.itis.gr201.ponomarev.springcars.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import ru.kpfu.itis.gr201.ponomarev.springcars.model.Message;

import javax.transaction.Transactional;
import java.util.List;

@Repository
public interface MessageRepository extends JpaRepository<Message, Integer> {

    List<Message> findAllByAdvertisementId(int advertisementId);

    @Query(value = "SELECT * FROM messages WHERE advertisement_id = :advertisementId AND ((sender_id = :senderId AND recipient_id = :recipientId) OR (sender_id = :recipientId AND recipient_id = :senderId)) ORDER BY sent_ts DESC", nativeQuery = true)
    List<Message> getAllOfAdvertisementAndUsers(
            @Param("advertisementId") int advertisementId,
            @Param("senderId") int senderId,
            @Param("recipientId") int recipientId
    );

    @Query("SELECT DISTINCT m.advertisementId FROM Message m " +
            "WHERE m.advertisementId IN (SELECT a.id FROM Advertisement a WHERE a.sellerId != :userId) " +
            "AND m.senderId = :userId")
    List<Integer> getAllAdvertisementIdsToWhichUserSentMessage(@Param("userId") int userId);

    @Modifying
    @Transactional
    @Query("UPDATE Message m SET m.isRead = true WHERE m.advertisementId = :advertisementId AND m.senderId = :senderId AND m.recipientId = :recipientId")
    void setAllAsReadForAdvertisementAndRecipient(@Param("advertisementId") int advertisementId, @Param("senderId") int senderId, @Param("recipientId") int recipientId);

    List<Message> findAllByRecipientIdAndIsReadFalse(int recipientId);
}
