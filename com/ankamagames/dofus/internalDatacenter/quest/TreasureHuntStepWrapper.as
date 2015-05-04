package com.ankamagames.dofus.internalDatacenter.quest
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import avmplus.getQualifiedClassName;
   import com.ankamagames.dofus.internalDatacenter.world.WorldPointWrapper;
   import com.ankamagames.dofus.datacenter.world.MapPosition;
   import com.ankamagames.dofus.datacenter.world.WorldMap;
   import com.ankamagames.dofus.datacenter.quest.treasureHunt.PointOfInterest;
   import com.ankamagames.dofus.datacenter.npcs.Npc;
   import com.ankamagames.dofus.types.enums.TreasureHuntStepTypeEnum;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.dofus.datacenter.world.SubArea;
   import com.ankamagames.dofus.datacenter.world.Area;
   import com.ankamagames.jerakine.types.enums.DirectionsEnum;
   import com.ankamagames.jerakine.utils.pattern.PatternDecoder;
   
   public class TreasureHuntStepWrapper extends Object implements IDataCenter
   {
      
      public function TreasureHuntStepWrapper()
      {
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(TreasureHuntStepWrapper));
      
      public static function create(param1:uint, param2:uint, param3:int, param4:int, param5:uint, param6:int = -1, param7:uint = 0) : TreasureHuntStepWrapper
      {
         var _loc8_:TreasureHuntStepWrapper = new TreasureHuntStepWrapper();
         _loc8_.type = param1;
         _loc8_.index = param2;
         _loc8_.direction = param3;
         _loc8_.mapId = param4;
         _loc8_.poiLabel = param5;
         _loc8_.flagState = param6;
         _loc8_.count = param7;
         return _loc8_;
      }
      
      public var index:uint;
      
      public var type:uint;
      
      public var direction:int = -1;
      
      public var mapId:int = -1;
      
      public var poiLabel:uint = 0;
      
      public var flagState:int = -1;
      
      public var count:uint = 0;
      
      private var _stepText:String;
      
      private var _stepRolloverText:String;
      
      public function get text() : String
      {
         var _loc1_:WorldPointWrapper = null;
         var _loc2_:MapPosition = null;
         var _loc3_:WorldMap = null;
         var _loc4_:PointOfInterest = null;
         var _loc5_:Npc = null;
         if(!this._stepText)
         {
            if(this.type == TreasureHuntStepTypeEnum.START)
            {
               _loc1_ = new WorldPointWrapper(this.mapId);
               this._stepText = I18n.getUiText("ui.common.start") + " [" + _loc1_.outdoorX + "," + _loc1_.outdoorY + "]";
               _loc2_ = MapPosition.getMapPositionById(this.mapId);
               if((_loc2_) && _loc2_.worldMap > 1)
               {
                  _loc3_ = WorldMap.getWorldMapById(_loc2_.worldMap);
                  this._stepText = this._stepText + (_loc3_?" " + _loc3_.name:"");
               }
            }
            else if(this.type == TreasureHuntStepTypeEnum.DIRECTION_TO_POI)
            {
               _loc4_ = PointOfInterest.getPointOfInterestById(this.poiLabel);
               if(_loc4_)
               {
                  this._stepText = _loc4_.name;
               }
               else
               {
                  this._stepText = "???";
               }
            }
            else if(this.type == TreasureHuntStepTypeEnum.DIRECTION)
            {
               this._stepText = "x" + this.count;
            }
            else if(this.type == TreasureHuntStepTypeEnum.DIRECTION_TO_HINT)
            {
               _loc5_ = Npc.getNpcById(this.count);
               this._stepText = _loc5_.name;
            }
            else if(this.type == TreasureHuntStepTypeEnum.FIGHT)
            {
               this._stepText = "";
            }
            else if(this.type == TreasureHuntStepTypeEnum.UNKNOWN)
            {
               this._stepText = "?";
            }
            
            
            
            
            
         }
         return this._stepText;
      }
      
      public function get overText() : String
      {
         var _loc1_:String = null;
         var _loc2_:SubArea = null;
         var _loc3_:Area = null;
         if(!this._stepRolloverText)
         {
            if(this.type == TreasureHuntStepTypeEnum.START)
            {
               _loc2_ = SubArea.getSubAreaByMapId(this.mapId);
               if(_loc2_)
               {
                  _loc3_ = _loc2_.area;
                  if(_loc3_)
                  {
                     this._stepRolloverText = _loc3_.name + " (" + _loc2_.name + ")";
                  }
               }
            }
            else if(this.type == TreasureHuntStepTypeEnum.DIRECTION_TO_POI || this.type == TreasureHuntStepTypeEnum.DIRECTION_TO_HINT)
            {
               if(this.direction == DirectionsEnum.RIGHT)
               {
                  _loc1_ = I18n.getUiText("ui.treasureHunt.theEast");
               }
               else if(this.direction == DirectionsEnum.DOWN)
               {
                  _loc1_ = I18n.getUiText("ui.treasureHunt.theSouth");
               }
               else if(this.direction == DirectionsEnum.LEFT)
               {
                  _loc1_ = I18n.getUiText("ui.treasureHunt.theWest");
               }
               else if(this.direction == DirectionsEnum.UP)
               {
                  _loc1_ = I18n.getUiText("ui.treasureHunt.theNorth");
               }
               else if(this.direction == DirectionsEnum.DOWN_LEFT)
               {
                  _loc1_ = I18n.getUiText("ui.treasureHunt.theSouthWest");
               }
               else if(this.direction == DirectionsEnum.DOWN_RIGHT)
               {
                  _loc1_ = I18n.getUiText("ui.treasureHunt.theSouthEast");
               }
               else if(this.direction == DirectionsEnum.UP_LEFT)
               {
                  _loc1_ = I18n.getUiText("ui.treasureHunt.theNorthWest");
               }
               else if(this.direction == DirectionsEnum.UP_RIGHT)
               {
                  _loc1_ = I18n.getUiText("ui.treasureHunt.theNorthEast");
               }
               
               
               
               
               
               
               
               this._stepRolloverText = I18n.getUiText("ui.treasureHunt.followDirectionToPOI",[_loc1_,"[" + this._stepText + "]"]);
            }
            else if(this.type == TreasureHuntStepTypeEnum.DIRECTION)
            {
               if(this.direction == DirectionsEnum.RIGHT)
               {
                  _loc1_ = I18n.getUiText("ui.treasureHunt.theEast");
               }
               else if(this.direction == DirectionsEnum.DOWN)
               {
                  _loc1_ = I18n.getUiText("ui.treasureHunt.theSouth");
               }
               else if(this.direction == DirectionsEnum.LEFT)
               {
                  _loc1_ = I18n.getUiText("ui.treasureHunt.theWest");
               }
               else if(this.direction == DirectionsEnum.UP)
               {
                  _loc1_ = I18n.getUiText("ui.treasureHunt.theNorth");
               }
               else if(this.direction == DirectionsEnum.DOWN_LEFT)
               {
                  _loc1_ = I18n.getUiText("ui.treasureHunt.theSouthWest");
               }
               else if(this.direction == DirectionsEnum.DOWN_RIGHT)
               {
                  _loc1_ = I18n.getUiText("ui.treasureHunt.theSouthEast");
               }
               else if(this.direction == DirectionsEnum.UP_LEFT)
               {
                  _loc1_ = I18n.getUiText("ui.treasureHunt.theNorthWest");
               }
               else if(this.direction == DirectionsEnum.UP_RIGHT)
               {
                  _loc1_ = I18n.getUiText("ui.treasureHunt.theNorthEast");
               }
               
               
               
               
               
               
               
               this._stepRolloverText = PatternDecoder.combine(I18n.getUiText("ui.treasureHunt.followDirection",[this.count,_loc1_]),"n",this.count <= 1);
            }
            
            
         }
         return this._stepRolloverText;
      }
      
      public function update(param1:uint, param2:uint, param3:int, param4:int, param5:uint, param6:int = -1, param7:uint = 0) : void
      {
         this.type = param1;
         this.index = param2;
         this.direction = param3;
         this.mapId = param4;
         this.poiLabel = param5;
         this.flagState = param6;
         this.count = param7;
      }
   }
}
