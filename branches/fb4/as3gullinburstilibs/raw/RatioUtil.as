package org.casalib.util {
    import flash.geom.Rectangle;
    import org.casalib.math.Percent;
    
    /**
        Provides utility functions for ratio scaling.
        
        @author Aaron Clinger
        @version 04/03/09
    */
    public class RatioUtil {
        
        /**
            Determines the ratio of width to height.
            
            @param size: The area's width and height expressed as a <code>Rectangle</code>. The <code>Rectangle</code>'s <code>x</code> and <code>y</code> values are ignored.
        */
        public static function widthToHeight(size:Rectangle):Number {
            return size.width / size.height;
        }
        
        /**
            Determines the ratio of height to width.
            
            @param size: The area's width and height expressed as a <code>Rectangle</code>. The <code>Rectangle</code>'s <code>x</code> and <code>y</code> values are ignored.
        */
        public static function heightToWidth(size:Rectangle):Number {
            return size.height / size.width;
        }
        
        /**
            Scales an area's width and height while preserving aspect ratio.
            
            @param size: The area's width and height expressed as a <code>Rectangle</code>. The <code>Rectangle</code>'s <code>x</code> and <code>y</code> values are ignored.
            @param amount: The amount you wish to scale by.
            @param snapToPixel: Force the scale to whole pixels <code>true</code>, or allow sub-pixels <code>false</code>.
        */
        public static function scale(size:Rectangle, amount:Percent, snapToPixel:Boolean = true):Rectangle {
            return RatioUtil._defineRect(size, size.width * amount.decimalPercentage, size.height * amount.decimalPercentage, snapToPixel);
        }
        
        /**
            Scales the width of an area while preserving aspect ratio.
            
            @param size: The area's width and height expressed as a <code>Rectangle</code>. The <code>Rectangle</code>'s <code>x</code> and <code>y</code> values are ignored.
            @param height: The new height of the area.
            @param snapToPixel: Force the scale to whole pixels <code>true</code>, or allow sub-pixels <code>false</code>.
        */
        public static function scaleWidth(size:Rectangle, height:Number, snapToPixel:Boolean = true):Rectangle {
            return RatioUtil._defineRect(size, height * RatioUtil.widthToHeight(size), height, snapToPixel);
        }
        
        /**
            Scales the height of an area while preserving aspect ratio.
            
            @param size: The area's width and height expressed as a <code>Rectangle</code>. The <code>Rectangle</code>'s <code>x</code> and <code>y</code> values are ignored.
            @param width: The new width of the area.
            @param snapToPixel: Force the scale to whole pixels <code>true</code>, or allow sub-pixels <code>false</code>.
        */
        public static function scaleHeight(size:Rectangle, width:Number, snapToPixel:Boolean = true):Rectangle {
            return RatioUtil._defineRect(size, width, width * RatioUtil.heightToWidth(size), snapToPixel);
        }
        
        /**
            Resizes an area to fill the bounding area while preserving aspect ratio.
            
            @param size: The area's width and height expressed as a <code>Rectangle</code>. The <code>Rectangle</code>'s <code>x</code> and <code>y</code> values are ignored.
            @param bounds: The area to fill. The <code>Rectangle</code>'s <code>x</code> and <code>y</code> values are ignored.
            @param snapToPixel: Force the scale to whole pixels <code>true</code>, or allow sub-pixels <code>false</code>.
        */
        public static function scaleToFill(size:Rectangle, bounds:Rectangle, snapToPixel:Boolean = true):Rectangle {
            var scaled:Rectangle = RatioUtil.scaleHeight(size, bounds.width, snapToPixel);
            
            if (scaled.height < bounds.height)
                scaled = RatioUtil.scaleWidth(size, bounds.height, snapToPixel);
            
            return scaled;
        }
        
        /**
            Resizes an area to the maximum size of a bounding area without exceeding while preserving aspect ratio.
            
            @param size: The area's width and height expressed as a <code>Rectangle</code>. The <code>Rectangle</code>'s <code>x</code> and <code>y</code> values are ignored.
            @param bounds: The area the rectangle needs to fit within. The <code>Rectangle</code>'s <code>x</code> and <code>y</code> values are ignored.
            @param snapToPixel: Force the scale to whole pixels <code>true</code>, or allow sub-pixels <code>false</code>.
        */
        public static function scaleToFit(size:Rectangle, bounds:Rectangle, snapToPixel:Boolean = true):Rectangle {
            var scaled:Rectangle = RatioUtil.scaleHeight(size, bounds.width, snapToPixel);
            
            if (scaled.height > bounds.height)
                scaled = RatioUtil.scaleWidth(size, bounds.height, snapToPixel);
            
            return scaled;
        }
        
        protected static function _defineRect(size:Rectangle, width:Number, height:Number, snapToPixel:Boolean):Rectangle {
            var scaled:Rectangle = size.clone();
            scaled.width         = snapToPixel ? Math.round(width) : width;
            scaled.height        = snapToPixel ? Math.round(height) : height;
            
            return scaled;
        }
    }
}