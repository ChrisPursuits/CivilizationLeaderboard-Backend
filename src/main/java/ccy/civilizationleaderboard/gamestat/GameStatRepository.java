package ccy.civilizationleaderboard.gamestat;

import ccy.civilizationleaderboard.civilization.model.Civilization;
import ccy.civilizationleaderboard.game.Game;
import ccy.civilizationleaderboard.gamestat.model.GameStat;
import ccy.civilizationleaderboard.gamestat.model.Placement;
import ccy.civilizationleaderboard.user.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Set;

public interface GameStatRepository extends JpaRepository<GameStat, Integer> {

    Set<GameStat> findGameStatsByGameId(int gameId);

    //TODO improve this method using a combination of placement, militaryPoints etc. as a unique identifier in the db
    boolean existsByGameAndUserAndSelectedCivilizationAndPlacementAndVictoryPointsAndMilitaryPointsAndSciencePointsAndCulturePointsAndGoldAndReligiousPointsAndDiplomaticPoints(
            Game game,
            User user,
            Civilization civilization,
            Placement placement,
            int victoryPoints,
            int militaryPoints,
            int sciencePoints,
            int culturePoints,
            int gold,
            int religiousPoints,
            int diplomaticPoints);

    List<GameStat> findAllByUser(User user);
}
