package com.ankamagames.dofus.network.messages.game.prism
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class PrismFightDefendersSwapMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function PrismFightDefendersSwapMessage() {
         super();
      }
      
      public static const protocolId:uint = 5902;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var subAreaId:uint = 0;
      
      public var fightId:Number = 0;
      
      public var fighterId1:uint = 0;
      
      public var fighterId2:uint = 0;
      
      override public function getMessageId() : uint {
         return 5902;
      }
      
      public function initPrismFightDefendersSwapMessage(param1:uint=0, param2:Number=0, param3:uint=0, param4:uint=0) : PrismFightDefendersSwapMessage {
         this.subAreaId = param1;
         this.fightId = param2;
         this.fighterId1 = param3;
         this.fighterId2 = param4;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.subAreaId = 0;
         this.fightId = 0;
         this.fighterId1 = 0;
         this.fighterId2 = 0;
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
         this.serializeAs_PrismFightDefendersSwapMessage(param1);
      }
      
      public function serializeAs_PrismFightDefendersSwapMessage(param1:IDataOutput) : void {
         if(this.subAreaId < 0)
         {
            throw new Error("Forbidden value (" + this.subAreaId + ") on element subAreaId.");
         }
         else
         {
            param1.writeShort(this.subAreaId);
            param1.writeDouble(this.fightId);
            if(this.fighterId1 < 0)
            {
               throw new Error("Forbidden value (" + this.fighterId1 + ") on element fighterId1.");
            }
            else
            {
               param1.writeInt(this.fighterId1);
               if(this.fighterId2 < 0)
               {
                  throw new Error("Forbidden value (" + this.fighterId2 + ") on element fighterId2.");
               }
               else
               {
                  param1.writeInt(this.fighterId2);
                  return;
               }
            }
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_PrismFightDefendersSwapMessage(param1);
      }
      
      public function deserializeAs_PrismFightDefendersSwapMessage(param1:IDataInput) : void {
         this.subAreaId = param1.readShort();
         if(this.subAreaId < 0)
         {
            throw new Error("Forbidden value (" + this.subAreaId + ") on element of PrismFightDefendersSwapMessage.subAreaId.");
         }
         else
         {
            this.fightId = param1.readDouble();
            this.fighterId1 = param1.readInt();
            if(this.fighterId1 < 0)
            {
               throw new Error("Forbidden value (" + this.fighterId1 + ") on element of PrismFightDefendersSwapMessage.fighterId1.");
            }
            else
            {
               this.fighterId2 = param1.readInt();
               if(this.fighterId2 < 0)
               {
                  throw new Error("Forbidden value (" + this.fighterId2 + ") on element of PrismFightDefendersSwapMessage.fighterId2.");
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
