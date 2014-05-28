package com.ankamagames.dofus.logic.game.fight.miscs
{
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
   import com.ankamagames.atouin.managers.EntitiesManager;
   import com.ankamagames.dofus.network.types.game.context.FightEntityDispositionInformations;
   
   public class FightReachableCellsMaker extends Object
   {
      
      public function FightReachableCellsMaker(infos:GameFightFighterInformations, fromCellId:int = -1, movementPoint:int = -1) {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      private var _cellGrid:Vector.<Vector.<_ReachableCellStore>>;
      
      private var _reachableCells:Vector.<uint>;
      
      private var _unreachableCells:Vector.<uint>;
      
      private var _mapPoint:MapPoint;
      
      private var _infos:GameFightFighterInformations;
      
      private var _mp:int;
      
      private var _waitingCells:Vector.<_ReachableCellStore>;
      
      private var _watchedCells:Vector.<_ReachableCellStore>;
      
      public function get reachableCells() : Vector.<uint> {
         return this._reachableCells;
      }
      
      public function get unreachableCells() : Vector.<uint> {
         return this._unreachableCells;
      }
      
      private function compute() : void {
         var tmpCells:Vector.<_ReachableCellStore> = null;
         var node:_ReachableCellStore = null;
         var mp:int = this._mp;
         var untacledMp:int = this._mp;
         this._waitingCells = new Vector.<_ReachableCellStore>();
         this._watchedCells = new Vector.<_ReachableCellStore>();
         this.markNode(this._mapPoint.x,this._mapPoint.y,mp,untacledMp);
         while((this._waitingCells.length) || (this._watchedCells.length))
         {
            if(this._waitingCells.length)
            {
               tmpCells = this._waitingCells;
               this._waitingCells = new Vector.<_ReachableCellStore>();
            }
            else
            {
               tmpCells = this._watchedCells;
               this._watchedCells = new Vector.<_ReachableCellStore>();
            }
            for each(node in tmpCells)
            {
               mp = int(node.bestMp * node.evade + 0.49) - 1;
               untacledMp = node.bestUntackledMp - 1;
               if(MapPoint.isInMap(node.mapPoint.x - 1,node.mapPoint.y))
               {
                  this.markNode(node.mapPoint.x - 1,node.mapPoint.y,mp,untacledMp);
               }
               if(MapPoint.isInMap(node.mapPoint.x + 1,node.mapPoint.y))
               {
                  this.markNode(node.mapPoint.x + 1,node.mapPoint.y,mp,untacledMp);
               }
               if(MapPoint.isInMap(node.mapPoint.x,node.mapPoint.y - 1))
               {
                  this.markNode(node.mapPoint.x,node.mapPoint.y - 1,mp,untacledMp);
               }
               if(MapPoint.isInMap(node.mapPoint.x,node.mapPoint.y + 1))
               {
                  this.markNode(node.mapPoint.x,node.mapPoint.y + 1,mp,untacledMp);
               }
            }
         }
      }
      
      private function markNode(x:int, y:int, mp:int, untackledMp:int) : void {
         var index:* = 0;
         var xTab:int = x - this._mapPoint.x + this._mp;
         var yTab:int = y - this._mapPoint.y + this._mp;
         var node:_ReachableCellStore = this._cellGrid[xTab][yTab];
         if(!node)
         {
            node = new _ReachableCellStore(MapPoint.fromCoords(x,y),xTab,yTab,this._cellGrid);
            this._cellGrid[xTab][yTab] = node;
            node.findState(this._infos);
            if(node.state != _ReachableCellStore.STATE_UNREACHABLE)
            {
               if(mp >= 0)
               {
                  this._reachableCells.push(node.mapPoint.cellId);
               }
               else
               {
                  this._unreachableCells.push(node.mapPoint.cellId);
               }
            }
         }
         if(node.state == _ReachableCellStore.STATE_UNREACHABLE)
         {
            return;
         }
         if((!node.set) || (mp > node.bestMp) || (untackledMp > node.bestUntackledMp))
         {
            if((mp >= 0) && (node.bestMp < 0))
            {
               this._reachableCells.push(node.mapPoint.cellId);
               index = this._unreachableCells.indexOf(node.mapPoint.cellId);
               if(index == -1)
               {
                  throw new Error("INTERNAL ERROR : " + node.mapPoint.cellId + " : Can\'t delete cell because it don\'t exist");
               }
               else
               {
                  this._unreachableCells.splice(index,1);
               }
            }
            node.updateMp(mp,untackledMp);
            if(untackledMp > 0)
            {
               if(node.state == _ReachableCellStore.STATE_REACHABLE)
               {
                  this._waitingCells.push(node);
               }
               else if(node.state == _ReachableCellStore.STATE_WATCHED)
               {
                  this._watchedCells.push(node);
               }
               
            }
         }
      }
   }
}
import com.ankamagames.jerakine.types.positions.MapPoint;
import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
import com.ankamagames.atouin.data.map.CellData;
import com.ankamagames.atouin.managers.MapDisplayManager;

class _ReachableCellStore extends Object
{
   
   function _ReachableCellStore(mapPoint:MapPoint, gridX:int, gridY:int, cellGrid:Vector.<Vector.<_ReachableCellStore>>) {
      super();
      this.mapPoint = mapPoint;
      this.gridX = gridX;
      this.gridY = gridY;
      this.cellGrid = cellGrid;
   }
   
   public static const STATE_UNDEFINED:int = 0;
   
   public static const STATE_REACHABLE:int = 1;
   
   public static const STATE_UNREACHABLE:int = 2;
   
   public static const STATE_WATCHED:int = 3;
   
   public var mapPoint:MapPoint;
   
   public var state:int;
   
   public var evade:Number = 1;
   
   public var bestMp:int;
   
   public var bestUntackledMp:int;
   
   public var set:Boolean;
   
   public var gridX:int;
   
   public var gridY:int;
   
   public var cellGrid:Vector.<Vector.<_ReachableCellStore>>;
   
   public function findState(playerInfos:GameFightFighterInformations) : void {
      var neighbour:_ReachableCellStore = null;
      var cellData:CellData = CellData(MapDisplayManager.getInstance().getDataMapContainer().dataMap.cells[this.mapPoint.cellId]);
      if((!cellData.mov) || (cellData.nonWalkableDuringFight))
      {
         this.state = STATE_UNREACHABLE;
      }
      else
      {
         this.evade = 1;
         if(this.gridX > 0)
         {
            neighbour = this.cellGrid[this.gridX - 1][this.gridY];
            if((neighbour) && (neighbour.state == STATE_UNREACHABLE))
            {
               this.evade = this.evade * neighbour.evade;
            }
         }
         if(this.gridX < this.cellGrid.length - 1)
         {
            neighbour = this.cellGrid[this.gridX + 1][this.gridY];
            if((neighbour) && (neighbour.state == STATE_UNREACHABLE))
            {
               this.evade = this.evade * neighbour.evade;
            }
         }
         if(this.gridY > 0)
         {
            neighbour = this.cellGrid[this.gridX][this.gridY - 1];
            if((neighbour) && (neighbour.state == STATE_UNREACHABLE))
            {
               this.evade = this.evade * neighbour.evade;
            }
         }
         if(this.gridY < this.cellGrid[0].length - 1)
         {
            neighbour = this.cellGrid[this.gridX][this.gridY + 1];
            if((neighbour) && (neighbour.state == STATE_UNREACHABLE))
            {
               this.evade = this.evade * neighbour.evade;
            }
         }
         this.state = this.evade == 1?STATE_REACHABLE:STATE_WATCHED;
      }
   }
   
   public function updateMp(bestMp:int, bestUntackledMp:int) : void {
      this.set = true;
      if(bestMp > this.bestMp)
      {
         this.bestMp = bestMp;
      }
      if(bestUntackledMp > this.bestUntackledMp)
      {
         this.bestUntackledMp = bestUntackledMp;
      }
   }
}
