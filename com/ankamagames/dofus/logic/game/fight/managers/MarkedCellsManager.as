package com.ankamagames.dofus.logic.game.fight.managers
{
   import com.ankamagames.jerakine.interfaces.IDestroyable;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.utils.Dictionary;
   import com.ankamagames.dofus.datacenter.spells.Spell;
   import com.ankamagames.dofus.network.types.game.actions.fight.GameActionMarkedCell;
   import com.ankamagames.dofus.logic.game.fight.types.MarkInstance;
   import com.ankamagames.atouin.types.Selection;
   import com.ankamagames.jerakine.types.Color;
   import com.ankamagames.atouin.renderers.TrapZoneRenderer;
   import com.ankamagames.atouin.enums.PlacementStrataEnums;
   import com.ankamagames.dofus.network.enums.GameActionMarkCellsTypeEnum;
   import com.ankamagames.jerakine.types.zones.Cross;
   import com.ankamagames.atouin.utils.DataMapProvider;
   import com.ankamagames.jerakine.types.zones.Lozenge;
   import com.ankamagames.jerakine.types.zones.Custom;
   import com.ankamagames.atouin.managers.SelectionManager;
   import com.ankamagames.dofus.types.entities.Glyph;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.atouin.AtouinConstants;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   
   public class MarkedCellsManager extends Object implements IDestroyable
   {
      
      public function MarkedCellsManager() {
         super();
         if(_self != null)
         {
            throw new SingletonError("MarkedCellsManager is a singleton and should not be instanciated directly.");
         }
         else
         {
            this._marks = new Dictionary(true);
            this._glyphs = new Dictionary(true);
            this._markUid = 0;
            return;
         }
      }
      
      private static const MARK_SELECTIONS_PREFIX:String = "FightMark";
      
      private static var _log:Logger;
      
      private static var _self:MarkedCellsManager;
      
      public static function getInstance() : MarkedCellsManager {
         if(_self == null)
         {
            _self = new MarkedCellsManager();
         }
         return _self;
      }
      
      private var _marks:Dictionary;
      
      private var _glyphs:Dictionary;
      
      private var _markUid:uint;
      
      public function addMark(markId:int, markType:int, associatedSpell:Spell, cells:Vector.<GameActionMarkedCell>) : void {
         var mi:MarkInstance = null;
         var markedCell:GameActionMarkedCell = null;
         var s:Selection = null;
         var cellsId:Vector.<uint> = null;
         var gamcell:GameActionMarkedCell = null;
         var cell:uint = 0;
         if((!this._marks[markId]) || (this._marks[markId].cells.length == 0))
         {
            mi = new MarkInstance();
            mi.markId = markId;
            mi.markType = markType;
            mi.associatedSpell = associatedSpell;
            mi.selections = new Vector.<Selection>(0,false);
            mi.cells = new Vector.<uint>(0,false);
            if(cells.length > 0)
            {
               markedCell = cells[0];
               s = new Selection();
               s.color = new Color(markedCell.cellColor);
               s.renderer = new TrapZoneRenderer(PlacementStrataEnums.STRATA_GLYPH);
               cellsId = new Vector.<uint>();
               for each(gamcell in cells)
               {
                  cellsId.push(gamcell.cellId);
               }
               if(markedCell.cellsType == GameActionMarkCellsTypeEnum.CELLS_CROSS)
               {
                  s.zone = new Cross(0,markedCell.zoneSize,DataMapProvider.getInstance());
               }
               else if(markedCell.zoneSize > 0)
               {
                  s.zone = new Lozenge(0,markedCell.zoneSize,DataMapProvider.getInstance());
               }
               else
               {
                  s.zone = new Custom(cellsId);
               }
               
               SelectionManager.getInstance().addSelection(s,this.getSelectionUid(),markedCell.cellId);
               for each(cell in s.cells)
               {
                  mi.cells.push(cell);
               }
               mi.selections.push(s);
            }
            this._marks[markId] = mi;
            this.updateDataMapProvider();
         }
      }
      
      public function getMarkDatas(markId:int) : MarkInstance {
         return this._marks[markId];
      }
      
      public function removeMark(markId:int) : void {
         var s:Selection = null;
         var selections:Vector.<Selection> = (this._marks[markId] as MarkInstance).selections;
         for each(s in selections)
         {
            s.remove();
         }
         delete this._marks[markId];
         this.updateDataMapProvider();
      }
      
      public function addGlyph(glyph:Glyph, markId:int) : void {
         this._glyphs[markId] = glyph;
      }
      
      public function getGlyph(markId:int) : Glyph {
         return this._glyphs[markId] as Glyph;
      }
      
      public function removeGlyph(markId:int) : void {
         if(this._glyphs[markId])
         {
            Glyph(this._glyphs[markId]).remove();
            delete this._glyphs[markId];
         }
      }
      
      public function destroy() : void {
         var mark:String = null;
         var i:* = 0;
         var num:* = 0;
         var glyph:String = null;
         var bufferId:Array = new Array();
         for(mark in this._marks)
         {
            bufferId.push(int(mark));
         }
         i = -1;
         num = bufferId.length;
         while(++i < num)
         {
            this.removeMark(bufferId[i]);
         }
         bufferId.length = 0;
         for(glyph in this._glyphs)
         {
            bufferId.push(int(glyph));
         }
         i = -1;
         num = bufferId.length;
         while(++i < num)
         {
            this.removeGlyph(bufferId[i]);
         }
         _self = null;
      }
      
      private function getSelectionUid() : String {
         return MARK_SELECTIONS_PREFIX + this._markUid++;
      }
      
      private function updateDataMapProvider() : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
   }
}
