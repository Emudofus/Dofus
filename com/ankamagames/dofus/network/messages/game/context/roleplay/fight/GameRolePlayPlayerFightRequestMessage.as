package com.ankamagames.dofus.network.messages.game.context.roleplay.fight
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GameRolePlayPlayerFightRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GameRolePlayPlayerFightRequestMessage() {
         super();
      }
      
      public static const protocolId:uint = 5731;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var targetId:uint = 0;
      
      public var targetCellId:int = 0;
      
      public var friendly:Boolean = false;
      
      override public function getMessageId() : uint {
         return 5731;
      }
      
      public function initGameRolePlayPlayerFightRequestMessage(param1:uint=0, param2:int=0, param3:Boolean=false) : GameRolePlayPlayerFightRequestMessage {
         this.targetId = param1;
         this.targetCellId = param2;
         this.friendly = param3;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.targetId = 0;
         this.targetCellId = 0;
         this.friendly = false;
         this._isInitialized = false;
      }
      
      override public function pack(param1:IDataOutput) : void {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(_loc2_);
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:IDataInput, param2:uint) : void {
         this.deserialize(param1);
      }
      
      public function serialize(param1:IDataOutput) : void {
         this.serializeAs_GameRolePlayPlayerFightRequestMessage(param1);
      }
      
      public function serializeAs_GameRolePlayPlayerFightRequestMessage(param1:IDataOutput) : void {
         if(this.targetId < 0)
         {
            throw new Error("Forbidden value (" + this.targetId + ") on element targetId.");
         }
         else
         {
            param1.writeInt(this.targetId);
            if(this.targetCellId < -1 || this.targetCellId > 559)
            {
               throw new Error("Forbidden value (" + this.targetCellId + ") on element targetCellId.");
            }
            else
            {
               param1.writeShort(this.targetCellId);
               param1.writeBoolean(this.friendly);
               return;
            }
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_GameRolePlayPlayerFightRequestMessage(param1);
      }
      
      public function deserializeAs_GameRolePlayPlayerFightRequestMessage(param1:IDataInput) : void {
         this.targetId = param1.readInt();
         if(this.targetId < 0)
         {
            throw new Error("Forbidden value (" + this.targetId + ") on element of GameRolePlayPlayerFightRequestMessage.targetId.");
         }
         else
         {
            this.targetCellId = param1.readShort();
            if(this.targetCellId < -1 || this.targetCellId > 559)
            {
               throw new Error("Forbidden value (" + this.targetCellId + ") on element of GameRolePlayPlayerFightRequestMessage.targetCellId.");
            }
            else
            {
               this.friendly = param1.readBoolean();
               return;
            }
         }
      }
   }
}
