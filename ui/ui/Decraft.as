package ui
{
   public class Decraft extends Craft
   {
      
      public function Decraft() {
         super();
      }
      
      override public function main(params:Object) : void {
         showRecipes = false;
         btn_lbl_btn_ok.text = uiApi.getText("ui.common.decraft");
         super.main(params);
      }
      
      override public function onRelease(target:Object) : void {
         switch(target)
         {
            case btn_ok:
               modCommon.openPopup(uiApi.getText("ui.popup.warning"),uiApi.getText("ui.craft.decraftConfirm"),[uiApi.getText("ui.common.yes"),uiApi.getText("ui.common.no")],[onConfirmCraftRecipe,onCancelCraftRecipe],onConfirmCraftRecipe,onCancelCraftRecipe);
               break;
            default:
               super.onRelease(target);
         }
      }
   }
}
