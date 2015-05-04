package com.ankamagames.dofus.logic.game.common.frames
{
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.dofus.network.messages.debug.DebugHighlightCellsMessage;
   import com.ankamagames.dofus.network.messages.debug.DebugInClientMessage;
   import com.ankamagames.atouin.managers.MapDisplayManager;
   import com.ankamagames.atouin.enums.PlacementStrataEnums;
   import com.ankamagames.dofus.network.enums.DebugLevelEnum;
   import com.ankamagames.dofus.network.messages.debug.DebugClearHighlightCellsMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.CurrentMapMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightJoinMessage;
   import com.ankamagames.atouin.managers.SelectionManager;
   import com.ankamagames.atouin.types.Selection;
   import com.ankamagames.atouin.renderers.ZoneDARenderer;
   import com.ankamagames.jerakine.types.Color;
   import com.ankamagames.jerakine.types.zones.Custom;
   
   public class DebugFrame extends Object implements Frame
   {
      
      public function DebugFrame()
      {
         this._aZones = new Array();
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(DebugFrame));
      
      private var _sName:String;
      
      private var _aZones:Array;
      
      public function get priority() : int
      {
         return 0;
      }
      
      public function process(param1:Message) : Boolean
      {
         var _loc2_:DebugHighlightCellsMessage = null;
         var _loc3_:uint = 0;
         var _loc4_:Vector.<uint> = null;
         var _loc5_:Vector.<uint> = null;
         var _loc6_:DebugInClientMessage = null;
         switch(true)
         {
            case param1 is DebugHighlightCellsMessage:
               _loc2_ = param1 as DebugHighlightCellsMessage;
               this._sName = "debug_zone" + _loc2_.color + "_" + Math.round(Math.random() * 10000);
               _loc4_ = new Vector.<uint>(0);
               _loc5_ = new Vector.<uint>(0);
               for each(_loc3_ in _loc2_.cells)
               {
                  if(MapDisplayManager.getInstance().renderer.isCellUnderFixture(_loc3_))
                  {
                     _loc4_.push(_loc3_);
                  }
                  else
                  {
                     _loc5_.push(_loc3_);
                  }
               }
               if(_loc4_.length > 0)
               {
                  this.displayZone(this._sName + "_foreground",_loc4_,_loc2_.color,PlacementStrataEnums.STRATA_FOREGROUND);
                  this._aZones.push(this._sName + "_foreground");
               }
               if(_loc5_.length > 0)
               {
                  this.displayZone(this._sName,_loc5_,_loc2_.color,PlacementStrataEnums.STRATA_MOVEMENT);
                  this._aZones.push(this._sName);
               }
               return true;
            case param1 is DebugClearHighlightCellsMessage:
            case param1 is CurrentMapMessage:
            case param1 is GameFightJoinMessage:
               this.clear();
               return false;
            case param1 is DebugInClientMessage:
               _loc6_ = param1 as DebugInClientMessage;
               switch(_loc6_.level)
               {
                  case DebugLevelEnum.LEVEL_DEBUG:
                     _log.debug(_loc6_.message);
                     break;
                  case DebugLevelEnum.LEVEL_ERROR:
                     _log.error(_loc6_.message);
                     break;
                  case DebugLevelEnum.LEVEL_FATAL:
                     _log.fatal(_loc6_.message);
                     break;
                  case DebugLevelEnum.LEVEL_INFO:
                     _log.info(_loc6_.message);
                     break;
                  case DebugLevelEnum.LEVEL_TRACE:
                     _log.trace(_loc6_.message);
                     break;
                  case DebugLevelEnum.LEVEL_WARN:
                     _log.warn(_loc6_.message);
                     break;
               }
               return true;
            default:
               return false;
         }
      }
      
      public function pushed() : Boolean
      {
         return true;
      }
      
      public function pulled() : Boolean
      {
         return true;
      }
      
      private function clear() : void
      {
         var _loc1_:String = null;
         for each(_loc1_ in this._aZones)
         {
            SelectionManager.getInstance().getSelection(_loc1_).remove();
         }
      }
      
      private function displayZone(param1:String, param2:Vector.<uint>, param3:uint, param4:uint) : void
      {
         var _loc5_:Selection = new Selection();
         _loc5_.renderer = new ZoneDARenderer(param4);
         _loc5_.color = new Color(param3);
         _loc5_.zone = new Custom(param2);
         SelectionManager.getInstance().addSelection(_loc5_,param1);
         SelectionManager.getInstance().update(param1);
      }
   }
}
