package ru.kpfu.itis.gr201.ponomarev.springcars.model;

import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.sql.Timestamp;
import java.time.LocalDateTime;

@Entity
@Table(name = "messages")
@Data
@NoArgsConstructor
public class Message {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "sender_id", nullable = false)
    private int senderId;

    @Column(name = "recipient_id", nullable = false)
    private int recipientId;

    @Column(name = "advertisement_id", nullable = false)
    private int advertisementId;

    @Column(name = "message", nullable = false, length = 2000)
    private String message;

    @Column(name = "sent_ts", nullable = false)
    private Timestamp sentTs;

    @Column(name = "is_read", nullable = false)
    private boolean isRead;

    public Message(int senderId, int recipientId, int advertisementId, String message) {
        this.senderId = senderId;
        this.recipientId = recipientId;
        this.advertisementId = advertisementId;
        this.message = message;
        this.sentTs = Timestamp.valueOf(LocalDateTime.now());
        this.isRead = false;
    }

    @Override
    public String toString() {
        return message;
    }
}
