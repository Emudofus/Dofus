package com.ankamagames.dofus.network.messages.game.context
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GameContextRefreshEntityLookMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GameContextRefreshEntityLookMessage() {
         this.look = new EntityLook();
         super();
      }
      
      public static const protocolId:uint = 5637;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var id:int = 0;
      
      public var look:EntityLook;
      
      override public function getMessageId() : uint {
         return 5637;
      }
      
      public function initGameContextRefreshEntityLookMessage(id:int=0, look:EntityLook=null) : GameContextRefreshEntityLookMessage {
         this.id = id;
         this.look = look;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.id = 0;
         this.look = new EntityLook();
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
         this.serializeAs_GameContextRefreshEntityLookMessage(output);
      }
      
      public function serializeAs_GameContextRefreshEntityLookMessage(output:IDataOutput) : void {
         output.writeInt(this.id);
         this.look.serializeAs_EntityLook(output);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameContextRefreshEntityLookMessage(input);
      }
      
      public function deserializeAs_GameContextRefreshEntityLookMessage(input:IDataInput) : void {
         this.id = input.readInt();
         this.look = new EntityLook();
         this.look.deserialize(input);
      }
   }
}
