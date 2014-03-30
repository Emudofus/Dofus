package com.ankamagames.dofus.network.messages.game.context.dungeon
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import __AS3__.vec.*;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class DungeonKeyRingMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function DungeonKeyRingMessage() {
         this.availables = new Vector.<uint>();
         this.unavailables = new Vector.<uint>();
         super();
      }
      
      public static const protocolId:uint = 6299;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var availables:Vector.<uint>;
      
      public var unavailables:Vector.<uint>;
      
      override public function getMessageId() : uint {
         return 6299;
      }
      
      public function initDungeonKeyRingMessage(availables:Vector.<uint>=null, unavailables:Vector.<uint>=null) : DungeonKeyRingMessage {
         this.availables = availables;
         this.unavailables = unavailables;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.availables = new Vector.<uint>();
         this.unavailables = new Vector.<uint>();
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
         this.serializeAs_DungeonKeyRingMessage(output);
      }
      
      public function serializeAs_DungeonKeyRingMessage(output:IDataOutput) : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: ExecutionException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_DungeonKeyRingMessage(input);
      }
      
      public function deserializeAs_DungeonKeyRingMessage(input:IDataInput) : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: ExecutionException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
   }
}
