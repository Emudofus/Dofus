package com.ankamagames.dofus.network.messages.game.context.roleplay
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class MapFightCountMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function MapFightCountMessage() {
         super();
      }
      
      public static const protocolId:uint = 210;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var fightCount:uint = 0;
      
      override public function getMessageId() : uint {
         return 210;
      }
      
      public function initMapFightCountMessage(param1:uint=0) : MapFightCountMessage {
         this.fightCount = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.fightCount = 0;
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
         this.serializeAs_MapFightCountMessage(param1);
      }
      
      public function serializeAs_MapFightCountMessage(param1:IDataOutput) : void {
         if(this.fightCount < 0)
         {
            throw new Error("Forbidden value (" + this.fightCount + ") on element fightCount.");
         }
         else
         {
            param1.writeShort(this.fightCount);
            return;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_MapFightCountMessage(param1);
      }
      
      public function deserializeAs_MapFightCountMessage(param1:IDataInput) : void {
         this.fightCount = param1.readShort();
         if(this.fightCount < 0)
         {
            throw new Error("Forbidden value (" + this.fightCount + ") on element of MapFightCountMessage.fightCount.");
         }
         else
         {
            return;
         }
      }
   }
}
