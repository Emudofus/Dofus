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
      
      public function DebugFrame() {
         this._aZones = new Array();
         super();
      }
      
      protected static const _log:Logger;
      
      private var _sName:String;
      
      private var _aZones:Array;
      
      public function get priority() : int {
         return 0;
      }
      
      public function process(msg:Message) : Boolean {
         var dhcmsg:DebugHighlightCellsMessage = null;
         var cellId:uint = 0;
         var foregroundCells:Vector.<uint> = null;
         var normalCells:Vector.<uint> = null;
         var dicmsg:DebugInClientMessage = null;
         switch(true)
         {
            case msg is DebugHighlightCellsMessage:
               dhcmsg = msg as DebugHighlightCellsMessage;
               this._sName = "debug_zone" + dhcmsg.color + "_" + Math.round(Math.random() * 10000);
               foregroundCells = new Vector.<uint>(0);
               normalCells = new Vector.<uint>(0);
               for each(cellId in dhcmsg.cells)
               {
                  if(MapDisplayManager.getInstance().renderer.isCellUnderFixture(cellId))
                  {
                     foregroundCells.push(cellId);
                  }
                  else
                  {
                     normalCells.push(cellId);
                  }
               }
               if(foregroundCells.length > 0)
               {
                  this.displayZone(this._sName + "_foreground",foregroundCells,dhcmsg.color,PlacementStrataEnums.STRATA_FOREGROUND);
                  this._aZones.push(this._sName + "_foreground");
               }
               if(normalCells.length > 0)
               {
                  this.displayZone(this._sName,normalCells,dhcmsg.color,PlacementStrataEnums.STRATA_MOVEMENT);
                  this._aZones.push(this._sName);
               }
               return true;
            case msg is DebugClearHighlightCellsMessage:
            case msg is CurrentMapMessage:
            case msg is GameFightJoinMessage:
               this.clear();
               return false;
            case msg is DebugInClientMessage:
               dicmsg = msg as DebugInClientMessage;
               switch(dicmsg.level)
               {
                  case DebugLevelEnum.LEVEL_DEBUG:
                     _log.debug(dicmsg.message);
                     break;
                  case DebugLevelEnum.LEVEL_ERROR:
                     _log.error(dicmsg.message);
                     break;
                  case DebugLevelEnum.LEVEL_FATAL:
                     _log.fatal(dicmsg.message);
                     break;
                  case DebugLevelEnum.LEVEL_INFO:
                     _log.info(dicmsg.message);
                     break;
                  case DebugLevelEnum.LEVEL_TRACE:
                     _log.trace(dicmsg.message);
                     break;
                  case DebugLevelEnum.LEVEL_WARN:
                     _log.warn(dicmsg.message);
                     break;
               }
               return true;
            default:
               return false;
         }
      }
      
      public function pushed() : Boolean {
         return true;
      }
      
      public function pulled() : Boolean {
         return true;
      }
      
      private function clear() : void {
         var sName:String = null;
         for each(sName in this._aZones)
         {
            SelectionManager.getInstance().getSelection(sName).remove();
         }
      }
      
      private function displayZone(name:String, cells:Vector.<uint>, color:uint, pStrata:uint) : void {
         var s:Selection = new Selection();
         s.renderer = new ZoneDARenderer(pStrata);
         s.color = new Color(color);
         s.zone = new Custom(cells);
         SelectionManager.getInstance().addSelection(s,name);
         SelectionManager.getInstance().update(name);
      }
   }
}
