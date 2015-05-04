package com.ankamagames.dofus.network.messages.game.startup
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.startup.StartupActionAddObject;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class StartupActionAddMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function StartupActionAddMessage()
      {
         this.newAction = new StartupActionAddObject();
         super();
      }
      
      public static const protocolId:uint = 6538;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var newAction:StartupActionAddObject;
      
      override public function getMessageId() : uint
      {
         return 6538;
      }
      
      public function initStartupActionAddMessage(param1:StartupActionAddObject = null) : StartupActionAddMessage
      {
         this.newAction = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.newAction = new StartupActionAddObject();
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
         this.serializeAs_StartupActionAddMessage(param1);
      }
      
      public function serializeAs_StartupActionAddMessage(param1:ICustomDataOutput) : void
      {
         this.newAction.serializeAs_StartupActionAddObject(param1);
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_StartupActionAddMessage(param1);
      }
      
      public function deserializeAs_StartupActionAddMessage(param1:ICustomDataInput) : void
      {
         this.newAction = new StartupActionAddObject();
         this.newAction.deserialize(param1);
      }
   }
}
