package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class GameFightSpellCooldown extends Object implements INetworkType
   {
      
      public function GameFightSpellCooldown() {
         super();
      }
      
      public static const protocolId:uint = 205;
      
      public var spellId:int = 0;
      
      public var cooldown:uint = 0;
      
      public function getTypeId() : uint {
         return 205;
      }
      
      public function initGameFightSpellCooldown(spellId:int=0, cooldown:uint=0) : GameFightSpellCooldown {
         this.spellId = spellId;
         this.cooldown = cooldown;
         return this;
      }
      
      public function reset() : void {
         this.spellId = 0;
         this.cooldown = 0;
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_GameFightSpellCooldown(output);
      }
      
      public function serializeAs_GameFightSpellCooldown(output:IDataOutput) : void {
         output.writeInt(this.spellId);
         if(this.cooldown < 0)
         {
            throw new Error("Forbidden value (" + this.cooldown + ") on element cooldown.");
         }
         else
         {
            output.writeByte(this.cooldown);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameFightSpellCooldown(input);
      }
      
      public function deserializeAs_GameFightSpellCooldown(input:IDataInput) : void {
         this.spellId = input.readInt();
         this.cooldown = input.readByte();
         if(this.cooldown < 0)
         {
            throw new Error("Forbidden value (" + this.cooldown + ") on element of GameFightSpellCooldown.cooldown.");
         }
         else
         {
            return;
         }
      }
   }
}
