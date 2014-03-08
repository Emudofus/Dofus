package com.ankamagames.dofus.network.messages.game.context.roleplay.fight.arena
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GameRolePlayArenaUpdatePlayerInfosMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GameRolePlayArenaUpdatePlayerInfosMessage() {
         super();
      }
      
      public static const protocolId:uint = 6301;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var rank:uint = 0;
      
      public var bestDailyRank:uint = 0;
      
      public var bestRank:uint = 0;
      
      public var victoryCount:uint = 0;
      
      public var arenaFightcount:uint = 0;
      
      override public function getMessageId() : uint {
         return 6301;
      }
      
      public function initGameRolePlayArenaUpdatePlayerInfosMessage(rank:uint=0, bestDailyRank:uint=0, bestRank:uint=0, victoryCount:uint=0, arenaFightcount:uint=0) : GameRolePlayArenaUpdatePlayerInfosMessage {
         this.rank = rank;
         this.bestDailyRank = bestDailyRank;
         this.bestRank = bestRank;
         this.victoryCount = victoryCount;
         this.arenaFightcount = arenaFightcount;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.rank = 0;
         this.bestDailyRank = 0;
         this.bestRank = 0;
         this.victoryCount = 0;
         this.arenaFightcount = 0;
         this._isInitialized = false;
      }
      
      override public function pack(output:IDataOutput) : void {
         var data:ByteArray = new ByteArray();
         this.serialize(data);
         writePacket(output,this.getMessageId(),data);
      }
      
      override public function unpack(input:IDataInput, length:uint) : void {
         this.deserialize(input);
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_GameRolePlayArenaUpdatePlayerInfosMessage(output);
      }
      
      public function serializeAs_GameRolePlayArenaUpdatePlayerInfosMessage(output:IDataOutput) : void {
         if((this.rank < 0) || (this.rank > 2300))
         {
            throw new Error("Forbidden value (" + this.rank + ") on element rank.");
         }
         else
         {
            output.writeShort(this.rank);
            if((this.bestDailyRank < 0) || (this.bestDailyRank > 2300))
            {
               throw new Error("Forbidden value (" + this.bestDailyRank + ") on element bestDailyRank.");
            }
            else
            {
               output.writeShort(this.bestDailyRank);
               if((this.bestRank < 0) || (this.bestRank > 2300))
               {
                  throw new Error("Forbidden value (" + this.bestRank + ") on element bestRank.");
               }
               else
               {
                  output.writeShort(this.bestRank);
                  if(this.victoryCount < 0)
                  {
                     throw new Error("Forbidden value (" + this.victoryCount + ") on element victoryCount.");
                  }
                  else
                  {
                     output.writeShort(this.victoryCount);
                     if(this.arenaFightcount < 0)
                     {
                        throw new Error("Forbidden value (" + this.arenaFightcount + ") on element arenaFightcount.");
                     }
                     else
                     {
                        output.writeShort(this.arenaFightcount);
                        return;
                     }
                  }
               }
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameRolePlayArenaUpdatePlayerInfosMessage(input);
      }
      
      public function deserializeAs_GameRolePlayArenaUpdatePlayerInfosMessage(input:IDataInput) : void {
         this.rank = input.readShort();
         if((this.rank < 0) || (this.rank > 2300))
         {
            throw new Error("Forbidden value (" + this.rank + ") on element of GameRolePlayArenaUpdatePlayerInfosMessage.rank.");
         }
         else
         {
            this.bestDailyRank = input.readShort();
            if((this.bestDailyRank < 0) || (this.bestDailyRank > 2300))
            {
               throw new Error("Forbidden value (" + this.bestDailyRank + ") on element of GameRolePlayArenaUpdatePlayerInfosMessage.bestDailyRank.");
            }
            else
            {
               this.bestRank = input.readShort();
               if((this.bestRank < 0) || (this.bestRank > 2300))
               {
                  throw new Error("Forbidden value (" + this.bestRank + ") on element of GameRolePlayArenaUpdatePlayerInfosMessage.bestRank.");
               }
               else
               {
                  this.victoryCount = input.readShort();
                  if(this.victoryCount < 0)
                  {
                     throw new Error("Forbidden value (" + this.victoryCount + ") on element of GameRolePlayArenaUpdatePlayerInfosMessage.victoryCount.");
                  }
                  else
                  {
                     this.arenaFightcount = input.readShort();
                     if(this.arenaFightcount < 0)
                     {
                        throw new Error("Forbidden value (" + this.arenaFightcount + ") on element of GameRolePlayArenaUpdatePlayerInfosMessage.arenaFightcount.");
                     }
                     else
                     {
                        return;
                     }
                  }
               }
            }
         }
      }
   }
}
