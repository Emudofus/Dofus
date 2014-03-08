package com.ankamagames.dofus.misc.lists
{
   import com.ankamagames.berilia.types.data.Hook;
   
   public class TriggerHookList extends Object
   {
      
      public function TriggerHookList() {
         super();
      }
      
      public static const NotificationList:Hook = new Hook("NotificationList",false);
      
      public static const PlayerMove:Hook = new Hook("PlayerMove",false);
      
      public static const PlayerFightMove:Hook = new Hook("PlayerFightMove",false);
      
      public static const FightSpellCast:Hook = new Hook("FightSpellCast",false);
      
      public static const FightResultVictory:Hook = new Hook("FightResultVictory",false);
      
      public static const MapWithMonsters:Hook = new Hook("MapWithMonsters",false);
      
      public static const PlayerNewSpell:Hook = new Hook("PlayerNewSpell",false);
      
      public static const CreaturesMode:Hook = new Hook("CreaturesMode",false);
      
      public static const PlayerIsDead:Hook = new Hook("PlayerIsDead",false);
      
      public static const OpenGrimoireQuestTab:Hook = new Hook("OpenGrimoireQuestTab",false);
      
      public static const OpenGrimoireAlignmentTab:Hook = new Hook("OpenGrimoireAlignmentTab",false);
      
      public static const OpenGrimoireJobTab:Hook = new Hook("OpenGrimoireJobTab",false);
      
      public static const OpenGrimoireCalendarTab:Hook = new Hook("OpenGrimoireCalendarTab",false);
      
      public static const OpenSmileys:Hook = new Hook("OpenSmileys",false);
      
      public static const OpenTeamSearch:Hook = new Hook("OpenTeamSearch",false);
      
      public static const OpenArena:Hook = new Hook("OpenArena",false);
      
      public static const OpenKrosmaster:Hook = new Hook("OpenKrosmaster",false);
      
      public static const OpenKrosmasterCollection:Hook = new Hook("OpenKrosmasterCollection",false);
   }
}
