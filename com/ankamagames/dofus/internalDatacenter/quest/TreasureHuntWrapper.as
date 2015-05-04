package com.ankamagames.dofus.internalDatacenter.quest
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.dofus.network.types.game.context.roleplay.treasureHunt.TreasureHuntStep;
   import com.ankamagames.dofus.network.types.game.context.roleplay.treasureHunt.TreasureHuntFlag;
   import com.ankamagames.dofus.types.enums.TreasureHuntStepTypeEnum;
   import com.ankamagames.dofus.network.types.game.context.roleplay.treasureHunt.TreasureHuntStepFollowDirectionToPOI;
   import com.ankamagames.dofus.network.types.game.context.roleplay.treasureHunt.TreasureHuntStepFollowDirection;
   import com.ankamagames.dofus.network.types.game.context.roleplay.treasureHunt.TreasureHuntStepFollowDirectionToHint;
   import com.ankamagames.jerakine.logger.Log;
   import avmplus.getQualifiedClassName;
   import com.ankamagames.dofus.network.types.game.context.roleplay.treasureHunt.TreasureHuntStepFight;
   
   public class TreasureHuntWrapper extends Object implements IDataCenter
   {
      
      public function TreasureHuntWrapper()
      {
         this.stepList = new Vector.<TreasureHuntStepWrapper>();
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(TreasureHuntWrapper));
      
      public static function create(param1:uint, param2:uint, param3:uint, param4:uint, param5:uint, param6:int, param7:Vector.<TreasureHuntStep>, param8:Vector.<TreasureHuntFlag>) : TreasureHuntWrapper
      {
         var _loc12_:TreasureHuntStep = null;
         var _loc13_:* = 0;
         var _loc14_:* = 0;
         var _loc9_:TreasureHuntWrapper = new TreasureHuntWrapper();
         _loc9_.questType = param1;
         _loc9_.checkPointCurrent = param3;
         _loc9_.checkPointTotal = param4;
         _loc9_.totalStepCount = param5;
         _loc9_.availableRetryCount = param6;
         var _loc10_:TreasureHuntStepWrapper = TreasureHuntStepWrapper.create(TreasureHuntStepTypeEnum.START,0,0,param2,0);
         _loc9_.stepList.push(_loc10_);
         var _loc11_:* = 0;
         for each(_loc12_ in param7)
         {
            _loc13_ = 0;
            _loc14_ = -1;
            if((param8) && (param8.length > _loc11_) && (param8[_loc11_]))
            {
               _loc13_ = param8[_loc11_].mapId;
               _loc14_ = param8[_loc11_].state;
            }
            if(_loc12_ is TreasureHuntStepFollowDirectionToPOI)
            {
               _loc9_.stepList.push(TreasureHuntStepWrapper.create(TreasureHuntStepTypeEnum.DIRECTION_TO_POI,_loc11_,(_loc12_ as TreasureHuntStepFollowDirectionToPOI).direction,_loc13_,(_loc12_ as TreasureHuntStepFollowDirectionToPOI).poiLabelId,_loc14_));
            }
            if(_loc12_ is TreasureHuntStepFollowDirection)
            {
               _loc9_.stepList.push(TreasureHuntStepWrapper.create(TreasureHuntStepTypeEnum.DIRECTION,_loc11_,(_loc12_ as TreasureHuntStepFollowDirection).direction,_loc13_,0,_loc14_,(_loc12_ as TreasureHuntStepFollowDirection).mapCount));
            }
            if(_loc12_ is TreasureHuntStepFollowDirectionToHint)
            {
               _loc9_.stepList.push(TreasureHuntStepWrapper.create(TreasureHuntStepTypeEnum.DIRECTION_TO_HINT,_loc11_,(_loc12_ as TreasureHuntStepFollowDirectionToHint).direction,_loc13_,0,_loc14_,(_loc12_ as TreasureHuntStepFollowDirectionToHint).npcId));
            }
            _loc11_++;
         }
         while(_loc9_.stepList.length <= param5)
         {
            _loc9_.stepList.push(TreasureHuntStepWrapper.create(TreasureHuntStepTypeEnum.UNKNOWN,63,0,0,0));
         }
         _loc9_.stepList.push(TreasureHuntStepWrapper.create(TreasureHuntStepTypeEnum.FIGHT,63,0,0,0));
         return _loc9_;
      }
      
      public var questType:uint;
      
      public var checkPointCurrent:uint;
      
      public var checkPointTotal:uint;
      
      public var totalStepCount:uint;
      
      public var availableRetryCount:int;
      
      public var stepList:Vector.<TreasureHuntStepWrapper>;
      
      public function update(param1:uint, param2:uint, param3:uint, param4:uint, param5:int, param6:Vector.<TreasureHuntStep>, param7:Vector.<TreasureHuntFlag>) : void
      {
         var _loc10_:TreasureHuntStep = null;
         var _loc11_:* = 0;
         var _loc12_:* = 0;
         this.questType = param1;
         this.checkPointCurrent = param3;
         this.checkPointTotal = param4;
         this.totalStepCount = param4;
         this.availableRetryCount = param5;
         this.stepList = new Vector.<TreasureHuntStepWrapper>();
         var _loc8_:TreasureHuntStepWrapper = TreasureHuntStepWrapper.create(TreasureHuntStepTypeEnum.START,0,0,param2,0);
         this.stepList.push(_loc8_);
         var _loc9_:* = 0;
         for each(_loc10_ in param6)
         {
            _loc11_ = 0;
            _loc12_ = -1;
            if((param7) && (param7.length > _loc9_) && (param7[_loc9_]))
            {
               _loc11_ = param7[_loc9_].mapId;
               _loc12_ = param7[_loc9_].state;
            }
            if(_loc10_ is TreasureHuntStepFollowDirectionToPOI)
            {
               this.stepList.push(TreasureHuntStepWrapper.create(TreasureHuntStepTypeEnum.DIRECTION_TO_POI,_loc9_,(_loc10_ as TreasureHuntStepFollowDirectionToPOI).direction,_loc11_,(_loc10_ as TreasureHuntStepFollowDirectionToPOI).poiLabelId,_loc12_));
            }
            else if(_loc10_ is TreasureHuntStepFollowDirectionToHint)
            {
               this.stepList.push(TreasureHuntStepWrapper.create(TreasureHuntStepTypeEnum.DIRECTION_TO_HINT,_loc9_,(_loc10_ as TreasureHuntStepFollowDirectionToHint).direction,_loc11_,0,_loc12_));
            }
            else if(_loc10_ is TreasureHuntStepFight)
            {
               this.stepList.push(TreasureHuntStepWrapper.create(TreasureHuntStepTypeEnum.FIGHT,63,0,0,0));
            }
            
            
            _loc9_++;
         }
      }
   }
}
