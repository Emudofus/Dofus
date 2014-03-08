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
      
      public function initMapFightCountMessage(fightCount:uint=0) : MapFightCountMessage {
         this.fightCount = fightCount;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.fightCount = 0;
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
         this.serializeAs_MapFightCountMessage(output);
      }
      
      public function serializeAs_MapFightCountMessage(output:IDataOutput) : void {
         if(this.fightCount < 0)
         {
            throw new Error("Forbidden value (" + this.fightCount + ") on element fightCount.");
         }
         else
         {
            output.writeShort(this.fightCount);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_MapFightCountMessage(input);
      }
      
      public function deserializeAs_MapFightCountMessage(input:IDataInput) : void {
         this.fightCount = input.readShort();
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
