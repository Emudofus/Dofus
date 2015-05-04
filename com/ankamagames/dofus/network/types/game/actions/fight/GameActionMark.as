package com.ankamagames.dofus.network.types.game.actions.fight
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class GameActionMark extends Object implements INetworkType
   {
      
      public function GameActionMark()
      {
         this.cells = new Vector.<GameActionMarkedCell>();
         super();
      }
      
      public static const protocolId:uint = 351;
      
      public var markAuthorId:int = 0;
      
      public var markTeamId:uint = 2;
      
      public var markSpellId:uint = 0;
      
      public var markSpellLevel:uint = 0;
      
      public var markId:int = 0;
      
      public var markType:int = 0;
      
      public var markimpactCell:int = 0;
      
      public var cells:Vector.<GameActionMarkedCell>;
      
      public var active:Boolean = false;
      
      public function getTypeId() : uint
      {
         return 351;
      }
      
      public function initGameActionMark(param1:int = 0, param2:uint = 2, param3:uint = 0, param4:uint = 0, param5:int = 0, param6:int = 0, param7:int = 0, param8:Vector.<GameActionMarkedCell> = null, param9:Boolean = false) : GameActionMark
      {
         this.markAuthorId = param1;
         this.markTeamId = param2;
         this.markSpellId = param3;
         this.markSpellLevel = param4;
         this.markId = param5;
         this.markType = param6;
         this.markimpactCell = param7;
         this.cells = param8;
         this.active = param9;
         return this;
      }
      
      public function reset() : void
      {
         this.markAuthorId = 0;
         this.markTeamId = 2;
         this.markSpellId = 0;
         this.markSpellLevel = 0;
         this.markId = 0;
         this.markType = 0;
         this.markimpactCell = 0;
         this.cells = new Vector.<GameActionMarkedCell>();
         this.active = false;
      }
      
      public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_GameActionMark(param1);
      }
      
      public function serializeAs_GameActionMark(param1:ICustomDataOutput) : void
      {
         param1.writeInt(this.markAuthorId);
         param1.writeByte(this.markTeamId);
         if(this.markSpellId < 0)
         {
            throw new Error("Forbidden value (" + this.markSpellId + ") on element markSpellId.");
         }
         else
         {
            param1.writeInt(this.markSpellId);
            if(this.markSpellLevel < 1 || this.markSpellLevel > 6)
            {
               throw new Error("Forbidden value (" + this.markSpellLevel + ") on element markSpellLevel.");
            }
            else
            {
               param1.writeByte(this.markSpellLevel);
               param1.writeShort(this.markId);
               param1.writeByte(this.markType);
               if(this.markimpactCell < -1 || this.markimpactCell > 559)
               {
                  throw new Error("Forbidden value (" + this.markimpactCell + ") on element markimpactCell.");
               }
               else
               {
                  param1.writeShort(this.markimpactCell);
                  param1.writeShort(this.cells.length);
                  var _loc2_:uint = 0;
                  while(_loc2_ < this.cells.length)
                  {
                     (this.cells[_loc2_] as GameActionMarkedCell).serializeAs_GameActionMarkedCell(param1);
                     _loc2_++;
                  }
                  param1.writeBoolean(this.active);
                  return;
               }
            }
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_GameActionMark(param1);
      }
      
      public function deserializeAs_GameActionMark(param1:ICustomDataInput) : void
      {
         var _loc4_:GameActionMarkedCell = null;
         this.markAuthorId = param1.readInt();
         this.markTeamId = param1.readByte();
         if(this.markTeamId < 0)
         {
            throw new Error("Forbidden value (" + this.markTeamId + ") on element of GameActionMark.markTeamId.");
         }
         else
         {
            this.markSpellId = param1.readInt();
            if(this.markSpellId < 0)
            {
               throw new Error("Forbidden value (" + this.markSpellId + ") on element of GameActionMark.markSpellId.");
            }
            else
            {
               this.markSpellLevel = param1.readByte();
               if(this.markSpellLevel < 1 || this.markSpellLevel > 6)
               {
                  throw new Error("Forbidden value (" + this.markSpellLevel + ") on element of GameActionMark.markSpellLevel.");
               }
               else
               {
                  this.markId = param1.readShort();
                  this.markType = param1.readByte();
                  this.markimpactCell = param1.readShort();
                  if(this.markimpactCell < -1 || this.markimpactCell > 559)
                  {
                     throw new Error("Forbidden value (" + this.markimpactCell + ") on element of GameActionMark.markimpactCell.");
                  }
                  else
                  {
                     var _loc2_:uint = param1.readUnsignedShort();
                     var _loc3_:uint = 0;
                     while(_loc3_ < _loc2_)
                     {
                        _loc4_ = new GameActionMarkedCell();
                        _loc4_.deserialize(param1);
                        this.cells.push(_loc4_);
                        _loc3_++;
                     }
                     this.active = param1.readBoolean();
                     return;
                  }
               }
            }
         }
      }
   }
}
