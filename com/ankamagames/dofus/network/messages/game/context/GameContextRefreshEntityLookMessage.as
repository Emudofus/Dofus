package com.ankamagames.dofus.network.messages.game.context
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class GameContextRefreshEntityLookMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GameContextRefreshEntityLookMessage()
      {
         this.look = new EntityLook();
         super();
      }
      
      public static const protocolId:uint = 5637;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var id:int = 0;
      
      public var look:EntityLook;
      
      override public function getMessageId() : uint
      {
         return 5637;
      }
      
      public function initGameContextRefreshEntityLookMessage(param1:int = 0, param2:EntityLook = null) : GameContextRefreshEntityLookMessage
      {
         this.id = param1;
         this.look = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.id = 0;
         this.look = new EntityLook();
         this._isInitialized = false;
      }
      
      override public function pack(param1:ICustomDataOutput) : void
      {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(new CustomDataWrapper(_loc2_));
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:ICustomDataInput, param2:uint) : void
      {
         this.deserialize(param1);
      }
      
      public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_GameContextRefreshEntityLookMessage(param1);
      }
      
      public function serializeAs_GameContextRefreshEntityLookMessage(param1:ICustomDataOutput) : void
      {
         param1.writeInt(this.id);
         this.look.serializeAs_EntityLook(param1);
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_GameContextRefreshEntityLookMessage(param1);
      }
      
      public function deserializeAs_GameContextRefreshEntityLookMessage(param1:ICustomDataInput) : void
      {
         this.id = param1.readInt();
         this.look = new EntityLook();
         this.look.deserialize(param1);
      }
   }
}
