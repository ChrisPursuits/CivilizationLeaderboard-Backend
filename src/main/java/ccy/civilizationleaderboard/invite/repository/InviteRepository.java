package ccy.civilizationleaderboard.invite.repository;

import ccy.civilizationleaderboard.invite.model.Invite;
import ccy.civilizationleaderboard.invite.model.InviteStatus;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface InviteRepository extends JpaRepository<Invite, Integer> {

    List<Invite> findAllByReceiverId(Integer receiverId);
    boolean existsByIssuer_IdAndReceiver_IdAndStatus(Integer issuerId, Integer receiverId, InviteStatus status);
}
