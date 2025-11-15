// screens/app/subscription_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vision_erp_app/screens/models/theme_model.dart';
import 'package:vision_erp_app/services/localization_service.dart';
import 'package:vision_erp_app/screens/providers/theme_notifier.dart';

class SubscriptionPage extends StatelessWidget {
  const SubscriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final isDarkMode = themeNotifier.isDarkMode;
    final localizationService = Provider.of<LocalizationService>(context);
    final isEnglish = localizationService.isEnglish();

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.grey[900] : Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.primaryColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.secondaryColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          isEnglish ? 'My Subscription' : 'اشتراكي',
          style: TextStyle(
            fontFamily: 'Cairo',
            color: AppColors.primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Current Plan Section
            _buildCurrentPlanSection(context, isEnglish),
            
            const SizedBox(height: 32),
            
            // Billing Information
            _buildBillingSection(context, isEnglish),
            
            const SizedBox(height: 32),
            
            // Available Plans
            _buildAvailablePlansSection(context, isEnglish),
            
            const SizedBox(height: 32),
            
            // FAQ Section
            _buildFAQSection(context, isEnglish),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentPlanSection(BuildContext context, bool isEnglish) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primaryColor.withOpacity(0.15),
            AppColors.secondaryColor.withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.workspace_premium,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isEnglish ? 'Project Plan' : 'خطة المشروع',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      isEnglish ? 'Active Subscription' : 'اشتراك نشط',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          
          // Plan Details
          _buildPlanDetail(
            context,
            Icons.calendar_today,
            isEnglish ? 'Billing Cycle' : 'دورة الفوترة',
            isEnglish ? 'Monthly' : 'شهري',
          ),
          
          const SizedBox(height: 12),
          
          _buildPlanDetail(
            context,
            Icons.payment,
            isEnglish ? 'Next Payment' : 'الدفعة القادمة',
            isEnglish ? 'December 15, 2024' : '15 ديسمبر 2024',
          ),
          
          const SizedBox(height: 12),
          
          _buildPlanDetail(
            context,
            Icons.credit_card,
            isEnglish ? 'Payment Method' : 'طريقة الدفع',
            isEnglish ? 'Credit Card **** 4242' : 'بطاقة ائتمان **** 4242',
          ),
          
          const SizedBox(height: 20),
          
          // Action Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    _showChangePlanDialog(context, isEnglish);
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primaryColor,
                    side: BorderSide(color: AppColors.primaryColor),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    isEnglish ? 'Change Plan' : 'تغيير الخطة',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    _showCancelSubscriptionDialog(context, isEnglish);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    isEnglish ? 'Cancel' : 'إلغاء',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPlanDetail(BuildContext context, IconData icon, String title, String value) {
    return Row(
      children: [
        Icon(
          icon,
          color: AppColors.primaryColor,
          size: 18,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBillingSection(BuildContext context, bool isEnglish) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isEnglish ? 'Billing History' : 'سجل الفواتير',
          style: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
        
        const SizedBox(height: 16),
        
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.primaryColor.withOpacity(0.1),
            ),
          ),
          child: Column(
            children: [
              _buildBillingItem(
                context,
                isEnglish ? 'November 15, 2024' : '15 نوفمبر 2024',
                '\$49.99',
                true,
              ),
              const Divider(height: 20),
              _buildBillingItem(
                context,
                isEnglish ? 'October 15, 2024' : '15 أكتوبر 2024',
                '\$49.99',
                true,
              ),
              const Divider(height: 20),
              _buildBillingItem(
                context,
                isEnglish ? 'September 15, 2024' : '15 سبتمبر 2024',
                '\$49.99',
                true,
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 12),
        
        Align(
          alignment: Alignment.center,
          child: TextButton(
            onPressed: () {
              _showAllInvoices(context, isEnglish);
            },
            child: Text(
              isEnglish ? 'View All Invoices' : 'عرض جميع الفواتير',
              style: TextStyle(
                fontFamily: 'Cairo',
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBillingItem(BuildContext context, String date, String amount, bool isPaid) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              date,
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              isPaid ? 'Paid' : 'Pending',
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 12,
                color: isPaid ? Colors.green : Colors.orange,
              ),
            ),
          ],
        ),
        Text(
          amount,
          style: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildAvailablePlansSection(BuildContext context, bool isEnglish) {
    final plans = [
      {
        'title': isEnglish ? 'Master' : 'الماستر',
        'price': isEnglish ? 'Free' : 'مجاني',
        'features': [
          isEnglish ? 'Unlimited personal files' : 'ملفات شخصية غير محدودة',
          isEnglish ? 'Email support' : 'دعم عبر البريد الإلكتروني',
          isEnglish ? 'CSV data export' : 'تصدير بيانات CSV',
        ],
        'isCurrent': false,
      },
      {
        'title': isEnglish ? 'Project Plan' : 'خطة المشروع',
        'price': isEnglish ? '\$49.99/month' : '49.99/شهرياً',
        'features': [
          isEnglish ? 'Up to 5 user accounts' : 'حتى 5 حسابات مستخدمين',
          isEnglish ? 'Team collaboration tools' : 'أدوات التعاون الجماعي',
          isEnglish ? 'Custom dashboards' : 'لوحات تحكم مخصصة',
          isEnglish ? 'Priority support' : 'دعم ذو أولوية',
        ],
        'isCurrent': true,
      },
      {
        'title': isEnglish ? 'Organization' : 'المؤسسة',
        'price': isEnglish ? '\$99.99/month' : '99.99/شهرياً',
        'features': [
          isEnglish ? 'Unlimited users' : 'مستخدمين غير محدودين',
          isEnglish ? 'Advanced analytics' : 'تحليلات متقدمة',
          isEnglish ? 'Custom integrations' : 'تكاملات مخصصة',
          isEnglish ? '24/7 phone support' : 'دعم هاتفي 24/7',
        ],
        'isCurrent': false,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isEnglish ? 'Available Plans' : 'الخطط المتاحة',
          style: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
        
        const SizedBox(height: 16),
        
        Column(
          children: plans.map((plan) {
            return _buildPlanCard(context, plan, isEnglish);
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildPlanCard(BuildContext context, Map<String, dynamic> plan, bool isEnglish) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(
          color: plan['isCurrent'] 
              ? AppColors.primaryColor 
              : AppColors.primaryColor.withOpacity(0.2),
          width: plan['isCurrent'] ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(12),
        color: plan['isCurrent'] 
            ? AppColors.primaryColor.withOpacity(0.05)
            : Colors.transparent,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                plan['title'],
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
              if (plan['isCurrent'])
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    isEnglish ? 'CURRENT' : 'الحالي',
                    style: const TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
          
          const SizedBox(height: 8),
          
          Text(
            plan['price'],
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
          
          const SizedBox(height: 12),
          
          Column(
            children: (plan['features'] as List<String>).map((feature) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: AppColors.primaryColor,
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        feature,
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 14,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          
          const SizedBox(height: 16),
          
          if (!plan['isCurrent'])
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _showUpgradeDialog(context, plan['title'], isEnglish);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  isEnglish ? 'Upgrade Plan' : 'ترقية الخطة',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFAQSection(BuildContext context, bool isEnglish) {
    final faqs = [
      {
        'question': isEnglish ? 'Can I change my plan anytime?' : 'هل يمكنني تغيير خطتي في أي وقت؟',
        'answer': isEnglish 
            ? 'Yes, you can upgrade or downgrade your plan at any time. Changes will be reflected in your next billing cycle.'
            : 'نعم، يمكنك ترقية أو تخفيض خطتك في أي وقت. ستظهر التغييرات في دورة الفوترة التالية.',
      },
      {
        'question': isEnglish ? 'What payment methods do you accept?' : 'ما هي طرق الدفع التي تقبلونها؟',
        'answer': isEnglish
            ? 'We accept all major credit cards, PayPal, and bank transfers for annual plans.'
            : 'نقبل جميع بطاقات الائتمان الرئيسية، PayPal، والتحويلات البنكية للخطط السنوية.',
      },
      {
        'question': isEnglish ? 'Is there a free trial?' : 'هل هناك نسخة تجريبية مجانية؟',
        'answer': isEnglish
            ? 'Yes, we offer a 14-day free trial for all paid plans. No credit card required.'
            : 'نعم، نقدم نسخة تجريبية مجانية لمدة 14 يوم لجميع الخطط المدفوعة. لا حاجة لبطاقة ائتمان.',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isEnglish ? 'Frequently Asked Questions' : 'الأسئلة الشائعة',
          style: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
        
        const SizedBox(height: 16),
        
        Column(
          children: faqs.map((faq) {
            return _buildFAQItem(context, faq['question']!, faq['answer']!);
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildFAQItem(BuildContext context, String question, String answer) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.primaryColor.withOpacity(0.1),
        ),
      ),
      child: ExpansionTile(
        title: Text(
          question,
          style: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Text(
              answer,
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 14,
                color: AppColors.textSecondary,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showChangePlanDialog(BuildContext context, bool isEnglish) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          isEnglish ? 'Change Plan' : 'تغيير الخطة',
          style: TextStyle(fontFamily: 'Cairo'),
        ),
        content: Text(
          isEnglish
              ? 'Are you sure you want to change your subscription plan?'
              : 'هل أنت متأكد من رغبتك في تغيير خطة الاشتراك؟',
          style: TextStyle(fontFamily: 'Cairo'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              isEnglish ? 'Cancel' : 'إلغاء',
              style: TextStyle(fontFamily: 'Cairo'),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Add plan change logic here
            },
            child: Text(
              isEnglish ? 'Change Plan' : 'تغيير الخطة',
              style: TextStyle(
                fontFamily: 'Cairo',
                color: AppColors.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showCancelSubscriptionDialog(BuildContext context, bool isEnglish) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          isEnglish ? 'Cancel Subscription' : 'إلغاء الاشتراك',
          style: TextStyle(fontFamily: 'Cairo'),
        ),
        content: Text(
          isEnglish
              ? 'Are you sure you want to cancel your subscription? You will lose access to premium features at the end of your billing period.'
              : 'هل أنت متأكد من رغبتك في إلغاء الاشتراك؟ ستفقد الوصول إلى الميزات المميزة في نهاية فترة الفوترة.',
          style: TextStyle(fontFamily: 'Cairo'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              isEnglish ? 'Keep Subscription' : 'الاحتفاظ بالاشتراك',
              style: TextStyle(fontFamily: 'Cairo'),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Add cancellation logic here
            },
            child: Text(
              isEnglish ? 'Cancel Subscription' : 'إلغاء الاشتراك',
              style: TextStyle(
                fontFamily: 'Cairo',
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAllInvoices(BuildContext context, bool isEnglish) {
    // Navigate to invoices page or show dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          isEnglish ? 'All Invoices' : 'جميع الفواتير',
          style: TextStyle(fontFamily: 'Cairo'),
        ),
        content: Text(
          isEnglish
              ? 'this page is under construction.'
              : 'هذه الصفحة قيد الإنشاء.',
          style: TextStyle(fontFamily: 'Cairo'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              isEnglish ? 'OK' : 'موافق',
              style: TextStyle(fontFamily: 'Cairo'),
            ),
          ),
        ],
      ),
    );
  }

  void _showUpgradeDialog(BuildContext context, String planName, bool isEnglish) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          isEnglish ? 'Upgrade Plan' : 'ترقية الخطة',
          style: TextStyle(fontFamily: 'Cairo'),
        ),
        content: Text(
          isEnglish
              ? 'Are you sure you want to upgrade to the $planName plan?'
              : 'هل أنت متأكد من رغبتك في الترقية إلى خطة $planName؟',
          style: TextStyle(fontFamily: 'Cairo'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              isEnglish ? 'Cancel' : 'إلغاء',
              style: TextStyle(fontFamily: 'Cairo'),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Add upgrade logic here
            },
            child: Text(
              isEnglish ? 'Upgrade' : 'ترقية',
              style: TextStyle(
                fontFamily: 'Cairo',
                color: AppColors.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}