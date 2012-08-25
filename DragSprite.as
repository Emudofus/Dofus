package 
{
    import flash.display.*;

    class DragSprite extends Sprite
    {

        function DragSprite(param1:BitmapData)
        {
            alpha = 0.8;
            addChild(new Bitmap(param1));
            return;
        }// end function

    }
}
