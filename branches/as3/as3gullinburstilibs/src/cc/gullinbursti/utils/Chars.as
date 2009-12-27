package cc.gullinbursti.utils {
	
	//] includes [!]>
	//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
	//]~=~=~=~=~=~=~=~=~=~=~=~=~=~[]~=~=~=~=~=~=~=~=~=~=~=~=~=~[
	
	/**
	 * 
	 * @author Gullinbursti
	 */
	// <[!] class delaration [¡]>
	public class Chars {
	//~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~~*~._
		
		//] class properties ]>
		//]=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~.
		
		// sub & super scripts
		public static const SUBSUPER_SCRIPTS:Array = new Array(
			["⁰", "₀"], // 0
			["¹", "₁"], // 1
			["²", "₂"], // 2
			["³", "₃"], // 3
			["⁴", "₄"], // 4
			["⁵", "₅"], // 5
			["⁶", "₆"], // 6
			["⁷", "₇"], // 7
			["⁸", "₈"], // 8
			["⁹", "₉"], // 9
			["ᴺ", "ⁿ"], // n
			["⁽", "₍"], // (
			["⁾", "₎"], // )
			["⁺", "₊"], // positive sign
			["⁻", "₋"]); // negative sign
			
		
		// misc math
		public static const MATH_GLYPHS:Array = new Array(
			"∞", // infinity
			"≈", // approx
			"≠", // not equal
			"±", // plus/minus
			"½", // 1/2 fraction
			"¼", // 1/4 fraction
			"⩲", // plus/equals
			"⩮", // times/equals
			"⁺", // positive sign
			"⁻", // negative sign
			"∪", // union
			"∩", // intersection
			"∠", // angle
			"°", // degrees
			"⦜", // right angle
			"÷", // divide sign
			"×", // times sign
			"·", // dot product sign
			"∆", // change in
			"∍", // element of
			"∑", // summation
			"√", // root
			"≤", // less than or equal to
			"≥", // greater than or equal to
			"⊂", // subset
			"⊃", // superset
			"⊄", // not a subset
			"⊅", // not a superset
			"∫", // integral
			"⦚", // squiggly bar
			"⊥", // perpendicular
			"‖", // parallel
			"№"); // number abbreviation
		
		
		// roman numerals
		public static const ROMAN_NUMERALS:Array = new Array(
			["Ⅰ", "ⅰ"], // 1
			["Ⅱ", "ⅱ"], // 2
			["Ⅲ", "ⅲ"], // 3
			["Ⅳ", "ⅳ"], // 4
			["Ⅴ", "ⅴ"], // 5
			["Ⅵ", "ⅵ"], // 6
			["Ⅶ", "ⅶ"], // 7
			["Ⅷ", "ⅷ"], // 8
			["Ⅸ", "ⅸ"], // 9
			["Ⅹ", "ⅹ"], // 10
			["Ⅺ", "ⅺ"], // 11
			["Ⅻ", "ⅻ"], // 12
			["Ⅼ", "ⅼ"], // 50
			["Ⅽ", "ⅽ"], // 100
			["Ⅾ", "ⅾ"], // 500
			["Ⅿ", "ⅿ"], // 1,000
			["ↀ", "ↀ"], // 1,000
			["ↁ", "ↁ"], // 5,000
			["ↂ", "ↂ"]); // 10,000
			
			
		// greek alphabet
		public static const GREEK_GLYPHS:Array = new Array(
			["Α", "α"], // alpha
			["Β", "β"], // beta
			["Γ", "γ"], // gamma
			["Δ", "δ"], // delta 
			["Ε", "ε"], // epsilon
			["Ζ", "ζ"], // zeta
			["Η", "η"], // eta
			["Θ", "θ"], // theta
			["Ι", "ι"], // iota
			["Κ", "κ"], // kappa
			["Λ", "λ"], // lambda
			["Μ", "μ"], // mu
			["Ν", "ν"], // nu
			["Ξ", "ξ"], // xi
			["Ο", "ο"], // omicron
			["Π", "π"], // pi
			["Ρ", "ρ"], // rho
			["Σ", "σ"], // sigma
			["Τ", "τ"], // tau
			["Υ", "υ"], // upsilon
			["Φ", "φ"], // phi
			["Χ", "χ"], // chi
			["Ψ", "ψ"], // psi
			["Ω", "ω"], // omega
			
			["Ϝ", "ϝ"], // digamma (numeral symbol)
			["Ϙ", "ϙ"], // qoppa (replaced by kappa)
			["ϟ", "Ϟ"], // koppa (replaced by kappa)
			["⊢", "⊢"], // heta (replaced by eta)
			["Ϻ", "ϻ"], // san (replaced by sigma)
			["ϡ", "Ϡ"], // sampi / disigma (san + pi = 900)
			
			["Ϛ", "ϛ"], // stigma (lunate sigma + tau)
			["Ϸ", "ϸ"]); // sho (added for Bactrian lang)
			
		
		// cyrillic chars
		public static const CYRILLIC_GLYPHS:Array = new Array(
			["Б", "б"], // be
			["Г", "г"], // ve
			["Ҕ", "ҕ"], // ghe
			["Д", "д"], // de
			["Ђ", "ђ"], // dje
			["Є", "є"], // ie (ukrainian)
			["Ж", "ж"], // zhe
			["З", "з"], // ze
			["Ӡ", "ӡ"], // dze (abkasian)
			["И", "и"], // i
			["К", "к"], // ka
			["Л", "л"], // el
			["М", "м"], // em
			["Н", "н"], // en
			["О", "о"], // o
			["П", "п"], // pe
			["Р", "р"], // er
			["С", "с"], // es
			["Т", "т"], // te
			["У", "у"], // u
			["Ф", "ф"], // ef
			["Х", "х"], // ha
			["Ѡ", "ѡ"], // omega
			["Ц", "ц"], // tse
			["Ч", "ч"], // che
			["Џ", "џ"], // dzhe
			["Ш", "ш"], // sha
			["Ы", "ы"], // yeru
			["Э", "э"], // e
			["Ю", "ю"], // yu 
			["Я", "я"], // ya
			["Ѧ", "ѧ"], // small yus
			["Ѫ", "ѫ"], // big yus
			["Ѯ", "ѯ"], // ksi
			["Ѱ", "ѱ"], // psi
			["Ѳ", "ѳ"], // fita
			["Ѵ", "ѵ"], // izhitsa
			["Ҁ", "ҁ"], // koppa
			["Ѣ", "ѣ"], // yat
			["Ә", "ә"], // schwa
			["Һ", "һ"], // shha
			
			["҂", "҂"], // 1000 sign
			["҈", "҈"], // 100,000 sign
			["҉", "҉"], // 1,000,000 sign
			
			["Ъ", "ъ"], // hard sign
			["Ҍ", "ҍ"], // semisoft sign
			["Ь", "ь"]); // soft sign
		
		
		// musical symbols
		public static const MUSIC_GLYPHS:Array = new Array(
			"𝄞", // treble clef
			"𝄢", // bass clef
			"♭", // flat
			"♯", // sharp
			"♮", // natural
			"𝄃", // start
			"𝄂", // end
			"𝄀", // measure
			"♩", // quarter note
			"♪", // eighth note
			"♫", // paired eighth note
			"♬", // paired sixtenth note
			"𝄆", // repeat start
			"𝄇", // repeat end
			"𝄈", // repeat
			"𝄐", // fermata top
			"𝄑", // fermata bottom
			"𝄒", // breathe
			"𝄪", // dbl sharp
			"𝄫"); // dbl flat 
			
		
		// glyphs of a six sided die
		public static const DICE_GLYPHS:Array = new Array(
			"⚀", // one 
			"⚁", // two
			"⚂", // three
			"⚃", // four
			"⚄", // five
			"⚅"); // six
		
		// <[=-=-=-=-=-=-=-=-=-=-=-=][=-=-=-=-=-=-=-=-=-=-=-=]>
		
		
		// <*] class constructor [*>
		public function Chars() {/* …\(^_^)/… */}
		//]~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~._
		
		//]~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=[>
		//]~=~=~=~=~=~=~=~=~=[>
	}
}