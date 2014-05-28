package com.ankamagames.dofus.network.messages.game.startup
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.startup.StartupActionAddObject;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class StartupActionsListMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function StartupActionsListMessage() {
         this.actions = new Vector.<StartupActionAddObject>();
         super();
      }
      
      public static const protocolId:uint = 1301;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var actions:Vector.<StartupActionAddObject>;
      
      override public function getMessageId() : uint {
         return 1301;
      }
      
      public function initStartupActionsListMessage(actions:Vector.<StartupActionAddObject> = null) : StartupActionsListMessage {
         this.actions = actions;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.actions = new Vector.<StartupActionAddObject>();
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
         this.serializeAs_StartupActionsListMessage(output);
      }
      
      public function serializeAs_StartupActionsListMessage(output:IDataOutput) : void {
         output.writeShort(this.actions.length);
         var _i1:uint = 0;
         while(_i1 < this.actions.length)
         {
            (this.actions[_i1] as StartupActionAddObject).serializeAs_StartupActionAddObject(output);
            _i1++;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_StartupActionsListMessage(input);
      }
      
      public function deserializeAs_StartupActionsListMessage(input:IDataInput) : void {
         var _item1:StartupActionAddObject = null;
         var _actionsLen:uint = input.readUnsignedShort();
         var _i1:uint = 0;
         while(_i1 < _actionsLen)
         {
            _item1 = new StartupActionAddObject();
            _item1.deserialize(input);
            this.actions.push(_item1);
            _i1++;
         }
      }
   }
}
