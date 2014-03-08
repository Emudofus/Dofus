package com.ankamagames.dofus.misc
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffect;
   import com.ankamagames.dofus.datacenter.items.IncarnationLevel;
   import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffectDice;
   import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceDate;
   import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceString;
   import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffectString;
   import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceInteger;
   import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffectInteger;
   import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceMinMax;
   import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffectMinMax;
   import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceDice;
   import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffectDate;
   import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceDuration;
   import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffectDuration;
   import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceLadder;
   import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffectLadder;
   import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceCreature;
   import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffectCreature;
   import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceMount;
   import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffectMount;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   
   public class ObjectEffectAdapter extends Object
   {
      
      public function ObjectEffectAdapter() {
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(ObjectEffectAdapter));
      
      public static function fromNetwork(param1:ObjectEffect) : EffectInstance {
         var _loc2_:EffectInstance = null;
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         var _loc6_:IncarnationLevel = null;
         var _loc7_:IncarnationLevel = null;
         if(param1 is ObjectEffectDice && param1.actionId == 669)
         {
            _loc2_ = new EffectInstanceDate();
            EffectInstanceDate(_loc2_).year = ObjectEffectDice(param1).diceNum;
            EffectInstanceDate(_loc2_).month = ObjectEffectDice(param1).diceSide * 32768 + ObjectEffectDice(param1).diceConst;
            _loc3_ = 1;
            do
            {
                  _loc6_ = IncarnationLevel.getIncarnationLevelByIdAndLevel(ObjectEffectDice(param1).diceNum,_loc3_);
                  if(_loc6_)
                  {
                     _loc4_ = _loc6_.requiredXp;
                  }
                  _loc3_++;
                  _loc7_ = IncarnationLevel.getIncarnationLevelByIdAndLevel(ObjectEffectDice(param1).diceNum,_loc3_);
                  if(_loc7_)
                  {
                     _loc5_ = _loc7_.requiredXp;
                  }
               }while(_loc5_ < EffectInstanceDate(_loc2_).month && _loc3_ < 51);
               
               _loc3_--;
               EffectInstanceDate(_loc2_).day = _loc3_;
               EffectInstanceDate(_loc2_).hour = 0;
               EffectInstanceDate(_loc2_).minute = 0;
            }
            else
            {
               switch(true)
               {
                  case param1 is ObjectEffectString:
                     _loc2_ = new EffectInstanceString();
                     EffectInstanceString(_loc2_).text = ObjectEffectString(param1).value;
                     break;
                  case param1 is ObjectEffectInteger:
                     _loc2_ = new EffectInstanceInteger();
                     EffectInstanceInteger(_loc2_).value = ObjectEffectInteger(param1).value;
                     break;
                  case param1 is ObjectEffectMinMax:
                     _loc2_ = new EffectInstanceMinMax();
                     EffectInstanceMinMax(_loc2_).min = ObjectEffectMinMax(param1).min;
                     EffectInstanceMinMax(_loc2_).max = ObjectEffectMinMax(param1).max;
                     break;
                  case param1 is ObjectEffectDice:
                     _loc2_ = new EffectInstanceDice();
                     EffectInstanceDice(_loc2_).diceNum = ObjectEffectDice(param1).diceNum;
                     EffectInstanceDice(_loc2_).diceSide = ObjectEffectDice(param1).diceSide;
                     EffectInstanceDice(_loc2_).value = ObjectEffectDice(param1).diceConst;
                     break;
                  case param1 is ObjectEffectDate:
                     _loc2_ = new EffectInstanceDate();
                     EffectInstanceDate(_loc2_).year = ObjectEffectDate(param1).year;
                     EffectInstanceDate(_loc2_).month = ObjectEffectDate(param1).month + 1;
                     EffectInstanceDate(_loc2_).day = ObjectEffectDate(param1).day;
                     EffectInstanceDate(_loc2_).hour = ObjectEffectDate(param1).hour;
                     EffectInstanceDate(_loc2_).minute = ObjectEffectDate(param1).minute;
                     break;
                  case param1 is ObjectEffectDuration:
                     _loc2_ = new EffectInstanceDuration();
                     EffectInstanceDuration(_loc2_).days = ObjectEffectDuration(param1).days;
                     EffectInstanceDuration(_loc2_).hours = ObjectEffectDuration(param1).hours;
                     EffectInstanceDuration(_loc2_).minutes = ObjectEffectDuration(param1).minutes;
                     break;
                  case param1 is ObjectEffectLadder:
                     _loc2_ = new EffectInstanceLadder();
                     EffectInstanceLadder(_loc2_).monsterFamilyId = ObjectEffectLadder(param1).monsterFamilyId;
                     EffectInstanceLadder(_loc2_).monsterCount = ObjectEffectLadder(param1).monsterCount;
                     break;
                  case param1 is ObjectEffectCreature:
                     _loc2_ = new EffectInstanceCreature();
                     EffectInstanceCreature(_loc2_).monsterFamilyId = ObjectEffectCreature(param1).monsterFamilyId;
                     break;
                  case param1 is ObjectEffectMount:
                     _loc2_ = new EffectInstanceMount();
                     EffectInstanceMount(_loc2_).date = ObjectEffectMount(param1).date;
                     EffectInstanceMount(_loc2_).modelId = ObjectEffectMount(param1).modelId;
                     EffectInstanceMount(_loc2_).mountId = ObjectEffectMount(param1).mountId;
                     break;
                  default:
                     _loc2_ = new EffectInstance();
               }
            }
            _loc2_.effectId = param1.actionId;
            _loc2_.duration = 0;
            return _loc2_;
         }
      }
   }
