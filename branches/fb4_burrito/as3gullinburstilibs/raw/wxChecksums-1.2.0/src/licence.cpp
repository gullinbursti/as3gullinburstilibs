/*
 * wxChecksums
 * Copyright (C) 2003-2004 Julien Couot
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
 */

/**
 * \file licence.cpp
 * Licence texts.
 */


//---------------------------------------------------------------------------
// For compilers that support precompilation, includes "wx.h".
#include <wx/wxprec.h>

#ifdef __BORLANDC__
#pragma hdrstop
#endif

#ifndef WX_PRECOMP
// Include your minimal set of headers here, or wx.h
#include <wx/wx.h>
#endif

#include "licence.hpp"

#include "compat.hpp"
//---------------------------------------------------------------------------


/// The C++ standard namespace.
using namespace std;


/**
 * Gets the GPL's licence text.
 *
 * @return The GPL's licence text.
 */
wxString getGPLLicenceText()
{
  wxString s = wxT("		    GNU GENERAL PUBLIC LICENSE\n");
  s += wxT("		       Version 2, June 1991\n");
  s += wxT("\n");
  s += wxT(" Copyright (C) 1989, 1991 Free Software Foundation, Inc.\n");
  s += wxT("                       59 Temple Place, Suite 330, Boston, MA  02111-1307  USA\n");
  s += wxT(" Everyone is permitted to copy and distribute verbatim copies\n");
  s += wxT(" of this license document, but changing it is not allowed.\n");
  s += wxT("\n");
  s += wxT("			    Preamble\n");
  s += wxT("\n");
  s += wxT("  The licenses for most software are designed to take away your\n");
  s += wxT("freedom to share and change it.  By contrast, the GNU General Public\n");
  s += wxT("License is intended to guarantee your freedom to share and change free\n");
  s += wxT("software--to make sure the software is free for all its users.  This\n");
  s += wxT("General Public License applies to most of the Free Software\n");
  s += wxT("Foundation's software and to any other program whose authors commit to\n");
  s += wxT("using it.  (Some other Free Software Foundation software is covered by\n");
  s += wxT("the GNU Library General Public License instead.)  You can apply it to\n");
  s += wxT("your programs, too.\n");
  s += wxT("\n");
  s += wxT("  When we speak of free software, we are referring to freedom, not\n");
  s += wxT("price.  Our General Public Licenses are designed to make sure that you\n");
  s += wxT("have the freedom to distribute copies of free software (and charge for\n");
  s += wxT("this service if you wish), that you receive source code or can get it\n");
  s += wxT("if you want it, that you can change the software or use pieces of it\n");
  s += wxT("in new free programs; and that you know you can do these things.\n");
  s += wxT("\n");
  s += wxT("  To protect your rights, we need to make restrictions that forbid\n");
  s += wxT("anyone to deny you these rights or to ask you to surrender the rights.\n");
  s += wxT("These restrictions translate to certain responsibilities for you if you\n");
  s += wxT("distribute copies of the software, or if you modify it.\n");
  s += wxT("\n");
  s += wxT("  For example, if you distribute copies of such a program, whether\n");
  s += wxT("gratis or for a fee, you must give the recipients all the rights that\n");
  s += wxT("you have.  You must make sure that they, too, receive or can get the\n");
  s += wxT("source code.  And you must show them these terms so they know their\n");
  s += wxT("rights.\n");
  s += wxT("\n");
  s += wxT("  We protect your rights with two steps: (1) copyright the software, and\n");
  s += wxT("(2) offer you this license which gives you legal permission to copy,\n");
  s += wxT("distribute and/or modify the software.\n");
  s += wxT("\n");
  s += wxT("  Also, for each author's protection and ours, we want to make certain\n");
  s += wxT("that everyone understands that there is no warranty for this free\n");
  s += wxT("software.  If the software is modified by someone else and passed on, we\n");
  s += wxT("want its recipients to know that what they have is not the original, so\n");
  s += wxT("that any problems introduced by others will not reflect on the original\n");
  s += wxT("authors' reputations.\n");
  s += wxT("\n");
  s += wxT("  Finally, any free program is threatened constantly by software\n");
  s += wxT("patents.  We wish to avoid the danger that redistributors of a free\n");
  s += wxT("program will individually obtain patent licenses, in effect making the\n");
  s += wxT("program proprietary.  To prevent this, we have made it clear that any\n");
  s += wxT("patent must be licensed for everyone's free use or not licensed at all.\n");
  s += wxT("\n");
  s += wxT("  The precise terms and conditions for copying, distribution and\n");
  s += wxT("modification follow.\n");
  s += wxT("\n");
  s += wxT("		    GNU GENERAL PUBLIC LICENSE\n");
  s += wxT("   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION\n");
  s += wxT("\n");
  s += wxT("  0. This License applies to any program or other work which contains\n");
  s += wxT("a notice placed by the copyright holder saying it may be distributed\n");
  s += wxT("under the terms of this General Public License.  The \"Program\", below,\n");
  s += wxT("refers to any such program or work, and a \"work based on the Program\"\n");
  s += wxT("means either the Program or any derivative work under copyright law:\n");
  s += wxT("that is to say, a work containing the Program or a portion of it,\n");
  s += wxT("either verbatim or with modifications and/or translated into another\n");
  s += wxT("language.  (Hereinafter, translation is included without limitation in\n");
  s += wxT("the term \"modification\".)  Each licensee is addressed as \"you\".\n");
  s += wxT("\n");
  s += wxT("Activities other than copying, distribution and modification are not\n");
  s += wxT("covered by this License; they are outside its scope.  The act of\n");
  s += wxT("running the Program is not restricted, and the output from the Program\n");
  s += wxT("is covered only if its contents constitute a work based on the\n");
  s += wxT("Program (independent of having been made by running the Program).\n");
  s += wxT("Whether that is true depends on what the Program does.\n");
  s += wxT("\n");
  s += wxT("  1. You may copy and distribute verbatim copies of the Program's\n");
  s += wxT("source code as you receive it, in any medium, provided that you\n");
  s += wxT("conspicuously and appropriately publish on each copy an appropriate\n");
  s += wxT("copyright notice and disclaimer of warranty; keep intact all the\n");
  s += wxT("notices that refer to this License and to the absence of any warranty;\n");
  s += wxT("and give any other recipients of the Program a copy of this License\n");
  s += wxT("along with the Program.\n");
  s += wxT("\n");
  s += wxT("You may charge a fee for the physical act of transferring a copy, and\n");
  s += wxT("you may at your option offer warranty protection in exchange for a fee.\n");
  s += wxT("\n");
  s += wxT("  2. You may modify your copy or copies of the Program or any portion\n");
  s += wxT("of it, thus forming a work based on the Program, and copy and\n");
  s += wxT("distribute such modifications or work under the terms of Section 1\n");
  s += wxT("above, provided that you also meet all of these conditions:\n");
  s += wxT("\n");
  s += wxT("    a) You must cause the modified files to carry prominent notices\n");
  s += wxT("    stating that you changed the files and the date of any change.\n");
  s += wxT("\n");
  s += wxT("    b) You must cause any work that you distribute or publish, that in\n");
  s += wxT("    whole or in part contains or is derived from the Program or any\n");
  s += wxT("    part thereof, to be licensed as a whole at no charge to all third\n");
  s += wxT("    parties under the terms of this License.\n");
  s += wxT("\n");
  s += wxT("    c) If the modified program normally reads commands interactively\n");
  s += wxT("    when run, you must cause it, when started running for such\n");
  s += wxT("    interactive use in the most ordinary way, to print or display an\n");
  s += wxT("    announcement including an appropriate copyright notice and a\n");
  s += wxT("    notice that there is no warranty (or else, saying that you provide\n");
  s += wxT("    a warranty) and that users may redistribute the program under\n");
  s += wxT("    these conditions, and telling the user how to view a copy of this\n");
  s += wxT("    License.  (Exception: if the Program itself is interactive but\n");
  s += wxT("    does not normally print such an announcement, your work based on\n");
  s += wxT("    the Program is not required to print an announcement.)\n");
  s += wxT("\n");
  s += wxT("These requirements apply to the modified work as a whole.  If\n");
  s += wxT("identifiable sections of that work are not derived from the Program,\n");
  s += wxT("and can be reasonably considered independent and separate works in\n");
  s += wxT("themselves, then this License, and its terms, do not apply to those\n");
  s += wxT("sections when you distribute them as separate works.  But when you\n");
  s += wxT("distribute the same sections as part of a whole which is a work based\n");
  s += wxT("on the Program, the distribution of the whole must be on the terms of\n");
  s += wxT("this License, whose permissions for other licensees extend to the\n");
  s += wxT("entire whole, and thus to each and every part regardless of who wrote it.\n");
  s += wxT("\n");
  s += wxT("Thus, it is not the intent of this section to claim rights or contest\n");
  s += wxT("your rights to work written entirely by you; rather, the intent is to\n");
  s += wxT("exercise the right to control the distribution of derivative or\n");
  s += wxT("collective works based on the Program.\n");
  s += wxT("\n");
  s += wxT("In addition, mere aggregation of another work not based on the Program\n");
  s += wxT("with the Program (or with a work based on the Program) on a volume of\n");
  s += wxT("a storage or distribution medium does not bring the other work under\n");
  s += wxT("the scope of this License.\n");
  s += wxT("\n");
  s += wxT("  3. You may copy and distribute the Program (or a work based on it,\n");
  s += wxT("under Section 2) in object code or executable form under the terms of\n");
  s += wxT("Sections 1 and 2 above provided that you also do one of the following:\n");
  s += wxT("\n");
  s += wxT("    a) Accompany it with the complete corresponding machine-readable\n");
  s += wxT("    source code, which must be distributed under the terms of Sections\n");
  s += wxT("    1 and 2 above on a medium customarily used for software interchange; or,\n");
  s += wxT("\n");
  s += wxT("    b) Accompany it with a written offer, valid for at least three\n");
  s += wxT("    years, to give any third party, for a charge no more than your\n");
  s += wxT("    cost of physically performing source distribution, a complete\n");
  s += wxT("    machine-readable copy of the corresponding source code, to be\n");
  s += wxT("    distributed under the terms of Sections 1 and 2 above on a medium\n");
  s += wxT("    customarily used for software interchange; or,\n");
  s += wxT("\n");
  s += wxT("    c) Accompany it with the information you received as to the offer\n");
  s += wxT("    to distribute corresponding source code.  (This alternative is\n");
  s += wxT("    allowed only for noncommercial distribution and only if you\n");
  s += wxT("    received the program in object code or executable form with such\n");
  s += wxT("    an offer, in accord with Subsection b above.)\n");
  s += wxT("\n");
  s += wxT("The source code for a work means the preferred form of the work for\n");
  s += wxT("making modifications to it.  For an executable work, complete source\n");
  s += wxT("code means all the source code for all modules it contains, plus any\n");
  s += wxT("associated interface definition files, plus the scripts used to\n");
  s += wxT("control compilation and installation of the executable.  However, as a\n");
  s += wxT("special exception, the source code distributed need not include\n");
  s += wxT("anything that is normally distributed (in either source or binary\n");
  s += wxT("form) with the major components (compiler, kernel, and so on) of the\n");
  s += wxT("operating system on which the executable runs, unless that component\n");
  s += wxT("itself accompanies the executable.\n");
  s += wxT("\n");
  s += wxT("If distribution of executable or object code is made by offering\n");
  s += wxT("access to copy from a designated place, then offering equivalent\n");
  s += wxT("access to copy the source code from the same place counts as\n");
  s += wxT("distribution of the source code, even though third parties are not\n");
  s += wxT("compelled to copy the source along with the object code.\n");
  s += wxT("\n");
  s += wxT("  4. You may not copy, modify, sublicense, or distribute the Program\n");
  s += wxT("except as expressly provided under this License.  Any attempt\n");
  s += wxT("otherwise to copy, modify, sublicense or distribute the Program is\n");
  s += wxT("void, and will automatically terminate your rights under this License.\n");
  s += wxT("However, parties who have received copies, or rights, from you under\n");
  s += wxT("this License will not have their licenses terminated so long as such\n");
  s += wxT("parties remain in full compliance.\n");
  s += wxT("\n");
  s += wxT("  5. You are not required to accept this License, since you have not\n");
  s += wxT("signed it.  However, nothing else grants you permission to modify or\n");
  s += wxT("distribute the Program or its derivative works.  These actions are\n");
  s += wxT("prohibited by law if you do not accept this License.  Therefore, by\n");
  s += wxT("modifying or distributing the Program (or any work based on the\n");
  s += wxT("Program), you indicate your acceptance of this License to do so, and\n");
  s += wxT("all its terms and conditions for copying, distributing or modifying\n");
  s += wxT("the Program or works based on it.\n");
  s += wxT("\n");
  s += wxT("  6. Each time you redistribute the Program (or any work based on the\n");
  s += wxT("Program), the recipient automatically receives a license from the\n");
  s += wxT("original licensor to copy, distribute or modify the Program subject to\n");
  s += wxT("these terms and conditions.  You may not impose any further\n");
  s += wxT("restrictions on the recipients' exercise of the rights granted herein.\n");
  s += wxT("You are not responsible for enforcing compliance by third parties to\n");
  s += wxT("this License.\n");
  s += wxT("\n");
  s += wxT("  7. If, as a consequence of a court judgment or allegation of patent\n");
  s += wxT("infringement or for any other reason (not limited to patent issues),\n");
  s += wxT("conditions are imposed on you (whether by court order, agreement or\n");
  s += wxT("otherwise) that contradict the conditions of this License, they do not\n");
  s += wxT("excuse you from the conditions of this License.  If you cannot\n");
  s += wxT("distribute so as to satisfy simultaneously your obligations under this\n");
  s += wxT("License and any other pertinent obligations, then as a consequence you\n");
  s += wxT("may not distribute the Program at all.  For example, if a patent\n");
  s += wxT("license would not permit royalty-free redistribution of the Program by\n");
  s += wxT("all those who receive copies directly or indirectly through you, then\n");
  s += wxT("the only way you could satisfy both it and this License would be to\n");
  s += wxT("refrain entirely from distribution of the Program.\n");
  s += wxT("\n");
  s += wxT("If any portion of this section is held invalid or unenforceable under\n");
  s += wxT("any particular circumstance, the balance of the section is intended to\n");
  s += wxT("apply and the section as a whole is intended to apply in other\n");
  s += wxT("circumstances.\n");
  s += wxT("\n");
  s += wxT("It is not the purpose of this section to induce you to infringe any\n");
  s += wxT("patents or other property right claims or to contest validity of any\n");
  s += wxT("such claims; this section has the sole purpose of protecting the\n");
  s += wxT("integrity of the free software distribution system, which is\n");
  s += wxT("implemented by public license practices.  Many people have made\n");
  s += wxT("generous contributions to the wide range of software distributed\n");
  s += wxT("through that system in reliance on consistent application of that\n");
  s += wxT("system; it is up to the author/donor to decide if he or she is willing\n");
  s += wxT("to distribute software through any other system and a licensee cannot\n");
  s += wxT("impose that choice.\n");
  s += wxT("\n");
  s += wxT("This section is intended to make thoroughly clear what is believed to\n");
  s += wxT("be a consequence of the rest of this License.\n");
  s += wxT("\n");
  s += wxT("  8. If the distribution and/or use of the Program is restricted in\n");
  s += wxT("certain countries either by patents or by copyrighted interfaces, the\n");
  s += wxT("original copyright holder who places the Program under this License\n");
  s += wxT("may add an explicit geographical distribution limitation excluding\n");
  s += wxT("those countries, so that distribution is permitted only in or among\n");
  s += wxT("countries not thus excluded.  In such case, this License incorporates\n");
  s += wxT("the limitation as if written in the body of this License.\n");
  s += wxT("\n");
  s += wxT("  9. The Free Software Foundation may publish revised and/or new versions\n");
  s += wxT("of the General Public License from time to time.  Such new versions will\n");
  s += wxT("be similar in spirit to the present version, but may differ in detail to\n");
  s += wxT("address new problems or concerns.\n");
  s += wxT("\n");
  s += wxT("Each version is given a distinguishing version number.  If the Program\n");
  s += wxT("specifies a version number of this License which applies to it and \"any\n");
  s += wxT("later version\", you have the option of following the terms and conditions\n");
  s += wxT("either of that version or of any later version published by the Free\n");
  s += wxT("Software Foundation.  If the Program does not specify a version number of\n");
  s += wxT("this License, you may choose any version ever published by the Free Software\n");
  s += wxT("Foundation.\n");
  s += wxT("\n");
  s += wxT("  10. If you wish to incorporate parts of the Program into other free\n");
  s += wxT("programs whose distribution conditions are different, write to the author\n");
  s += wxT("to ask for permission.  For software which is copyrighted by the Free\n");
  s += wxT("Software Foundation, write to the Free Software Foundation; we sometimes\n");
  s += wxT("make exceptions for this.  Our decision will be guided by the two goals\n");
  s += wxT("of preserving the free status of all derivatives of our free software and\n");
  s += wxT("of promoting the sharing and reuse of software generally.\n");
  s += wxT("\n");
  s += wxT("			    NO WARRANTY\n");
  s += wxT("\n");
  s += wxT("  11. BECAUSE THE PROGRAM IS LICENSED FREE OF CHARGE, THERE IS NO WARRANTY\n");
  s += wxT("FOR THE PROGRAM, TO THE EXTENT PERMITTED BY APPLICABLE LAW.  EXCEPT WHEN\n");
  s += wxT("OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR OTHER PARTIES\n");
  s += wxT("PROVIDE THE PROGRAM \"AS IS\" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED\n");
  s += wxT("OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF\n");
  s += wxT("MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.  THE ENTIRE RISK AS\n");
  s += wxT("TO THE QUALITY AND PERFORMANCE OF THE PROGRAM IS WITH YOU.  SHOULD THE\n");
  s += wxT("PROGRAM PROVE DEFECTIVE, YOU ASSUME THE COST OF ALL NECESSARY SERVICING,\n");
  s += wxT("REPAIR OR CORRECTION.\n");
  s += wxT("\n");
  s += wxT("  12. IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING\n");
  s += wxT("WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MAY MODIFY AND/OR\n");
  s += wxT("REDISTRIBUTE THE PROGRAM AS PERMITTED ABOVE, BE LIABLE TO YOU FOR DAMAGES,\n");
  s += wxT("INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL OR CONSEQUENTIAL DAMAGES ARISING\n");
  s += wxT("OUT OF THE USE OR INABILITY TO USE THE PROGRAM (INCLUDING BUT NOT LIMITED\n");
  s += wxT("TO LOSS OF DATA OR DATA BEING RENDERED INACCURATE OR LOSSES SUSTAINED BY\n");
  s += wxT("YOU OR THIRD PARTIES OR A FAILURE OF THE PROGRAM TO OPERATE WITH ANY OTHER\n");
  s += wxT("PROGRAMS), EVEN IF SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE\n");
  s += wxT("POSSIBILITY OF SUCH DAMAGES.\n");
  s += wxT("\n");
  s += wxT("		     END OF TERMS AND CONDITIONS\n");
  s += wxT("\n");
  s += wxT("	    How to Apply These Terms to Your New Programs\n");
  s += wxT("\n");
  s += wxT("  If you develop a new program, and you want it to be of the greatest\n");
  s += wxT("possible use to the public, the best way to achieve this is to make it\n");
  s += wxT("free software which everyone can redistribute and change under these terms.\n");
  s += wxT("\n");
  s += wxT("  To do so, attach the following notices to the program.  It is safest\n");
  s += wxT("to attach them to the start of each source file to most effectively\n");
  s += wxT("convey the exclusion of warranty; and each file should have at least\n");
  s += wxT("the \"copyright\" line and a pointer to where the full notice is found.\n");
  s += wxT("\n");
  s += wxT("    <one line to give the program's name and a brief idea of what it does.>\n");
  s += wxT("    Copyright (C) <year>  <name of author>\n");
  s += wxT("\n");
  s += wxT("    This program is free software; you can redistribute it and/or modify\n");
  s += wxT("    it under the terms of the GNU General Public License as published by\n");
  s += wxT("    the Free Software Foundation; either version 2 of the License, or\n");
  s += wxT("    (at your option) any later version.\n");
  s += wxT("\n");
  s += wxT("    This program is distributed in the hope that it will be useful,\n");
  s += wxT("    but WITHOUT ANY WARRANTY; without even the implied warranty of\n");
  s += wxT("    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the\n");
  s += wxT("    GNU General Public License for more details.\n");
  s += wxT("\n");
  s += wxT("    You should have received a copy of the GNU General Public License\n");
  s += wxT("    along with this program; if not, write to the Free Software\n");
  s += wxT("    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA\n");
  s += wxT("\n");
  s += wxT("\n");
  s += wxT("Also add information on how to contact you by electronic and paper mail.\n");
  s += wxT("\n");
  s += wxT("If the program is interactive, make it output a short notice like this\n");
  s += wxT("when it starts in an interactive mode:\n");
  s += wxT("\n");
  s += wxT("    Gnomovision version 69, Copyright (C) year name of author\n");
  s += wxT("    Gnomovision comes with ABSOLUTELY NO WARRANTY; for details type `show w'.\n");
  s += wxT("    This is free software, and you are welcome to redistribute it\n");
  s += wxT("    under certain conditions; type `show c' for details.\n");
  s += wxT("\n");
  s += wxT("The hypothetical commands `show w' and `show c' should show the appropriate\n");
  s += wxT("parts of the General Public License.  Of course, the commands you use may\n");
  s += wxT("be called something other than `show w' and `show c'; they could even be\n");
  s += wxT("mouse-clicks or menu items--whatever suits your program.\n");
  s += wxT("\n");
  s += wxT("You should also get your employer (if you work as a programmer) or your\n");
  s += wxT("school, if any, to sign a \"copyright disclaimer\" for the program, if\n");
  s += wxT("necessary.  Here is a sample; alter the names:\n");
  s += wxT("\n");
  s += wxT("  Yoyodyne, Inc., hereby disclaims all copyright interest in the program\n");
  s += wxT("  `Gnomovision' (which makes passes at compilers) written by James Hacker.\n");
  s += wxT("\n");
  s += wxT("  <signature of Ty Coon>, 1 April 1989\n");
  s += wxT("  Ty Coon, President of Vice\n");
  s += wxT("\n");
  s += wxT("This General Public License does not permit incorporating your program into\n");
  s += wxT("proprietary programs.  If your program is a subroutine library, you may\n");
  s += wxT("consider it more useful to permit linking proprietary applications with the\n");
  s += wxT("library.  If this is what you want to do, use the GNU Library General\n");
  s += wxT("Public License instead of this License.");

  return s;
}
//---------------------------------------------------------------------------
