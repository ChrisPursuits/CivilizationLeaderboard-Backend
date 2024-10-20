package ccy.civilizationleaderboard.user.model;

import ccy.civilizationleaderboard.game.Game;
import ccy.civilizationleaderboard.gamestat.model.GameStat;
import ccy.civilizationleaderboard.invite.model.Invite;
import ccy.civilizationleaderboard.leaderboard.Leaderboard;
import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.Collection;
import java.util.Date;
import java.util.List;


@Data
@Entity
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "app_user")
public class User implements UserDetails {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(unique=true)
    private String username;

    private String password;

    @Enumerated(EnumType.STRING)
    private Role role;

    private int totalGamesPlayed;

    private Date creationDate;

    @ElementCollection
    @CollectionTable(name = "user_placement_history", joinColumns = @JoinColumn(name = "app_user_id"))
    @Column(name = "placement")
    private List<Integer> placementHistory;

    //TODO
    //create a playedCivilizationTracker/history using a HashMap.


    //since the idea is that every civ 6 player should be able to create a leaderboard with their frinds the User owns the relationship
    @ManyToMany(mappedBy = "leaderboardMembers")
    @JsonBackReference
    private List<Leaderboard> leaderboardList;

    @ManyToMany
    @JoinTable(
            name = "user_games",
            joinColumns = @JoinColumn(name = "user_id"),
            inverseJoinColumns = @JoinColumn(name = "game_id")
    )
    @JsonManagedReference
    private List<Game> gameList;

    @OneToMany(mappedBy = "user")
    @JsonBackReference
    private List<GameStat> gameStatList;


    @OneToMany(mappedBy = "issuer")
    private List<Invite> issuedInvites;

    @OneToMany(mappedBy = "receiver")
    private List<Invite> receivedInvites;

    //used in AuthenticationServiceImpl for registering new users
    public User(String username, String password, Role role) {
        this.username = username;
        this.password = password;
        this.role = role;
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return List.of(new SimpleGrantedAuthority(role.name()));
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }
}
