package com.ankamagames.dofus.misc.utils
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.dofus.datacenter.items.Item;
   import com.ankamagames.dofus.datacenter.items.ItemType;
   import com.ankamagames.dofus.datacenter.jobs.Job;
   import com.ankamagames.dofus.datacenter.quest.Quest;
   import com.ankamagames.dofus.datacenter.quest.Achievement;
   import com.ankamagames.dofus.datacenter.appearance.Title;
   import com.ankamagames.dofus.datacenter.appearance.Ornament;
   import com.ankamagames.dofus.datacenter.spells.Spell;
   import com.ankamagames.dofus.datacenter.spells.SpellState;
   import com.ankamagames.dofus.datacenter.breeds.Breed;
   import com.ankamagames.dofus.datacenter.world.Area;
   import com.ankamagames.dofus.datacenter.world.SubArea;
   import com.ankamagames.dofus.datacenter.world.MapPosition;
   import com.ankamagames.dofus.datacenter.communication.Emoticon;
   import com.ankamagames.dofus.datacenter.monsters.Monster;
   import com.ankamagames.dofus.datacenter.monsters.MonsterRace;
   import com.ankamagames.dofus.datacenter.monsters.MonsterSuperRace;
   import com.ankamagames.dofus.datacenter.challenges.Challenge;
   import com.ankamagames.dofus.datacenter.alignments.AlignmentSide;
   import com.ankamagames.dofus.datacenter.world.Dungeon;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.logic.common.managers.HyperlinkItemManager;
   import com.ankamagames.jerakine.utils.misc.StringUtils;
   import com.ankamagames.dofus.logic.common.managers.HyperlinkShowQuestManager;
   import com.ankamagames.dofus.logic.common.managers.HyperlinkShowAchievementManager;
   import com.ankamagames.dofus.logic.common.managers.HyperlinkShowTitleManager;
   import com.ankamagames.dofus.logic.common.managers.HyperlinkShowOrnamentManager;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   
   public class ParamsDecoder extends Object
   {
      
      public function ParamsDecoder() {
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(ParamsDecoder));
      
      public static function applyParams(param1:String, param2:Array, param3:String="%") : String {
         var _loc10_:String = null;
         var _loc4_:* = false;
         var _loc5_:* = false;
         var _loc6_:* = "";
         var _loc7_:* = "";
         var _loc8_:* = "";
         var _loc9_:uint = 0;
         while(_loc9_ < param1.length)
         {
            _loc10_ = param1.charAt(_loc9_);
            if(_loc10_ == "$")
            {
               _loc4_ = true;
            }
            else
            {
               if(_loc10_ == param3)
               {
                  if(_loc9_ + 1 < param1.length && param1.charAt(_loc9_ + 1) == param3)
                  {
                     _loc5_ = false;
                     _loc4_ = false;
                     _loc9_++;
                  }
                  else
                  {
                     _loc4_ = false;
                     _loc5_ = true;
                  }
               }
            }
            if(_loc4_)
            {
               _loc6_ = _loc6_ + _loc10_;
            }
            else
            {
               if(_loc5_)
               {
                  if(_loc10_ == param3)
                  {
                     if(_loc7_.length == 0)
                     {
                        _loc7_ = _loc7_ + _loc10_;
                     }
                     else
                     {
                        _loc8_ = _loc8_ + processReplace(_loc6_,_loc7_,param2);
                        _loc6_ = "";
                        _loc7_ = "" + _loc10_;
                     }
                  }
                  else
                  {
                     if(_loc10_ >= "0" && _loc10_ <= "9")
                     {
                        _loc7_ = _loc7_ + _loc10_;
                        if(_loc9_ + 1 == param1.length)
                        {
                           _loc5_ = false;
                           _loc8_ = _loc8_ + processReplace(_loc6_,_loc7_,param2);
                           _loc6_ = "";
                           _loc7_ = "";
                        }
                     }
                     else
                     {
                        _loc5_ = false;
                        _loc8_ = _loc8_ + processReplace(_loc6_,_loc7_,param2);
                        _loc6_ = "";
                        _loc7_ = "";
                        _loc8_ = _loc8_ + _loc10_;
                     }
                  }
               }
               else
               {
                  if(_loc7_ != "")
                  {
                     _loc8_ = _loc8_ + processReplace(_loc6_,_loc7_,param2);
                     _loc6_ = "";
                     _loc7_ = "";
                  }
                  _loc8_ = _loc8_ + _loc10_;
               }
            }
            _loc9_++;
         }
         return _loc8_;
      }
      
      private static function processReplace(param1:String, param2:String, param3:Array) : String {
         var _loc5_:* = 0;
         var _loc6_:Item = null;
         var _loc7_:ItemType = null;
         var _loc8_:Job = null;
         var _loc9_:Quest = null;
         var _loc10_:Achievement = null;
         var _loc11_:Title = null;
         var _loc12_:Ornament = null;
         var _loc13_:Spell = null;
         var _loc14_:SpellState = null;
         var _loc15_:Breed = null;
         var _loc16_:Area = null;
         var _loc17_:SubArea = null;
         var _loc18_:MapPosition = null;
         var _loc19_:Emoticon = null;
         var _loc20_:Monster = null;
         var _loc21_:MonsterRace = null;
         var _loc22_:MonsterSuperRace = null;
         var _loc23_:Challenge = null;
         var _loc24_:AlignmentSide = null;
         var _loc25_:Array = null;
         var _loc26_:Dungeon = null;
         var _loc27_:ItemWrapper = null;
         var _loc4_:* = "";
         _loc5_ = int(Number(param2.substr(1)))-1;
         if(param1 == "")
         {
            _loc4_ = param3[_loc5_];
         }
         else
         {
            switch(param1)
            {
               case "$item":
                  _loc6_ = Item.getItemById(param3[_loc5_]);
                  if(_loc6_)
                  {
                     _loc27_ = ItemWrapper.create(0,0,param3[_loc5_],0,null,false);
                     _loc4_ = HyperlinkItemManager.newChatItem(_loc27_);
                  }
                  else
                  {
                     _log.error(param1 + " " + param3[_loc5_] + " introuvable");
                     _loc4_ = "";
                  }
                  break;
               case "$itemType":
                  _loc7_ = ItemType.getItemTypeById(param3[_loc5_]);
                  if(_loc7_)
                  {
                     _loc4_ = _loc7_.name;
                  }
                  else
                  {
                     _log.error(param1 + " " + param3[_loc5_] + " introuvable");
                     _loc4_ = "";
                  }
                  break;
               case "$quantity":
                  _loc4_ = StringUtils.formateIntToString(int(param3[_loc5_]));
                  break;
               case "$job":
                  _loc8_ = Job.getJobById(param3[_loc5_]);
                  if(_loc8_)
                  {
                     _loc4_ = _loc8_.name;
                  }
                  else
                  {
                     _log.error(param1 + " " + param3[_loc5_] + " introuvable");
                     _loc4_ = "";
                  }
                  break;
               case "$quest":
                  _loc9_ = Quest.getQuestById(param3[_loc5_]);
                  if(_loc9_)
                  {
                     _loc4_ = HyperlinkShowQuestManager.addQuest(_loc9_.id);
                  }
                  else
                  {
                     _log.error(param1 + " " + param3[_loc5_] + " introuvable");
                     _loc4_ = "";
                  }
                  break;
               case "$achievement":
                  _loc10_ = Achievement.getAchievementById(param3[_loc5_]);
                  if(_loc10_)
                  {
                     _loc4_ = HyperlinkShowAchievementManager.addAchievement(_loc10_.id);
                  }
                  else
                  {
                     _log.error(param1 + " " + param3[_loc5_] + " introuvable");
                     _loc4_ = "";
                  }
                  break;
               case "$title":
                  _loc11_ = Title.getTitleById(param3[_loc5_]);
                  if(_loc11_)
                  {
                     _loc4_ = HyperlinkShowTitleManager.addTitle(_loc11_.id);
                  }
                  else
                  {
                     _log.error(param1 + " " + param3[_loc5_] + " introuvable");
                     _loc4_ = "";
                  }
                  break;
               case "$ornament":
                  _loc12_ = Ornament.getOrnamentById(param3[_loc5_]);
                  if(_loc12_)
                  {
                     _loc4_ = HyperlinkShowOrnamentManager.addOrnament(_loc12_.id);
                  }
                  else
                  {
                     _log.error(param1 + " " + param3[_loc5_] + " introuvable");
                     _loc4_ = "";
                  }
                  break;
               case "$spell":
                  _loc13_ = Spell.getSpellById(param3[_loc5_]);
                  if(_loc13_)
                  {
                     _loc4_ = _loc13_.name;
                  }
                  else
                  {
                     _log.error(param1 + " " + param3[_loc5_] + " introuvable");
                     _loc4_ = "";
                  }
                  break;
               case "$spellState":
                  _loc14_ = SpellState.getSpellStateById(param3[_loc5_]);
                  if(_loc14_)
                  {
                     _loc4_ = _loc14_.name;
                  }
                  else
                  {
                     _log.error(param1 + " " + param3[_loc5_] + " introuvable");
                     _loc4_ = "";
                  }
                  break;
               case "$breed":
                  _loc15_ = Breed.getBreedById(param3[_loc5_]);
                  if(_loc15_)
                  {
                     _loc4_ = _loc15_.shortName;
                  }
                  else
                  {
                     _log.error(param1 + " " + param3[_loc5_] + " introuvable");
                     _loc4_ = "";
                  }
                  break;
               case "$area":
                  _loc16_ = Area.getAreaById(param3[_loc5_]);
                  if(_loc16_)
                  {
                     _loc4_ = _loc16_.name;
                  }
                  else
                  {
                     _log.error(param1 + " " + param3[_loc5_] + " introuvable");
                     _loc4_ = "";
                  }
                  break;
               case "$subarea":
                  _loc17_ = SubArea.getSubAreaById(param3[_loc5_]);
                  if(_loc17_)
                  {
                     _loc4_ = "{subArea," + param3[_loc5_] + "}";
                  }
                  else
                  {
                     _log.error(param1 + " " + param3[_loc5_] + " introuvable");
                     _loc4_ = "";
                  }
                  break;
               case "$map":
                  _loc18_ = MapPosition.getMapPositionById(param3[_loc5_]);
                  if(_loc18_)
                  {
                     if(_loc18_.name)
                     {
                        _loc4_ = _loc18_.name;
                     }
                     else
                     {
                        _loc4_ = "{map," + int(_loc18_.posX) + "," + int(_loc18_.posY) + "," + int(_loc18_.worldMap) + "}";
                     }
                  }
                  else
                  {
                     _log.error(param1 + " " + param3[_loc5_] + " introuvable");
                     _loc4_ = "";
                  }
                  break;
               case "$emote":
                  _loc19_ = Emoticon.getEmoticonById(param3[_loc5_]);
                  if(_loc19_)
                  {
                     _loc4_ = _loc19_.name;
                  }
                  else
                  {
                     _log.error(param1 + " " + param3[_loc5_] + " introuvable");
                     _loc4_ = "";
                  }
                  break;
               case "$monster":
                  _loc20_ = Monster.getMonsterById(param3[_loc5_]);
                  if(_loc20_)
                  {
                     _loc4_ = _loc20_.name;
                  }
                  else
                  {
                     _log.error(param1 + " " + param3[_loc5_] + " introuvable");
                     _loc4_ = "";
                  }
                  break;
               case "$monsterRace":
                  _loc21_ = MonsterRace.getMonsterRaceById(param3[_loc5_]);
                  if(_loc21_)
                  {
                     _loc4_ = _loc21_.name;
                  }
                  else
                  {
                     _log.error(param1 + " " + param3[_loc5_] + " introuvable");
                     _loc4_ = "";
                  }
                  break;
               case "$monsterSuperRace":
                  _loc22_ = MonsterSuperRace.getMonsterSuperRaceById(param3[_loc5_]);
                  if(_loc22_)
                  {
                     _loc4_ = _loc22_.name;
                  }
                  else
                  {
                     _log.error(param1 + " " + param3[_loc5_] + " introuvable");
                     _loc4_ = "";
                  }
                  break;
               case "$challenge":
                  _loc23_ = Challenge.getChallengeById(param3[_loc5_]);
                  if(_loc23_)
                  {
                     _loc4_ = _loc23_.name;
                  }
                  else
                  {
                     _log.error(param1 + " " + param3[_loc5_] + " introuvable");
                     _loc4_ = "";
                  }
                  break;
               case "$alignment":
                  _loc24_ = AlignmentSide.getAlignmentSideById(param3[_loc5_]);
                  if(_loc24_)
                  {
                     _loc4_ = _loc24_.name;
                  }
                  else
                  {
                     _log.error(param1 + " " + param3[_loc5_] + " introuvable");
                     _loc4_ = "";
                  }
                  break;
               case "$stat":
                  _loc25_ = I18n.getUiText("ui.item.characteristics").split(",");
                  if(_loc25_[param3[_loc5_]])
                  {
                     _loc4_ = _loc25_[param3[_loc5_]];
                  }
                  else
                  {
                     _log.error(param1 + " " + param3[_loc5_] + " introuvable");
                     _loc4_ = "";
                  }
                  break;
               case "$dungeon":
                  _loc26_ = Dungeon.getDungeonById(param3[_loc5_]);
                  if(_loc26_)
                  {
                     _loc4_ = _loc26_.name;
                  }
                  else
                  {
                     _log.error(param1 + " " + param3[_loc5_] + " introuvable");
                     _loc4_ = "";
                  }
                  break;
            }
         }
         return _loc4_;
      }
   }
}
