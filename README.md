# CareLoop Clinics — No-Show Guard

## AI-Powered Appointment Risk & Recovery Intelligence

### Project Overview

CareLoop is a healthcare operations analytics capstone
that combines Python, MySQL, Machine Learning,
Generative AI and an interactive dashboard to analyze
missed appointments and support appointment management.

The system is a historical-data prototype and
decision-support demonstration, not a live clinical system.

## Problem Statement

Missed appointments can reduce clinic efficiency,
waste available appointment slots and disrupt scheduling.

CareLoop explores patterns associated with no-shows,
estimates appointment-level risk and supports
more informed follow-up planning.

## Technology Stack

- Python and Pandas — data cleaning and analysis
- MySQL — relational storage and SQL analytics
- Scikit-learn — predictive machine learning
- Google Gemini — historical follow-up note analysis
- Pydantic — AI response validation
- Plotly — interactive visualizations
- ipywidgets — interactive dashboard controls
- Google Colab — development environment

## Project Workflow

1. Import and clean appointment records.
2. Validate data quality and rejected records.
3. Store and analyze records using MySQL.
4. Train and evaluate no-show prediction models.
5. Select a model using training-only cross-validation.
6. Export holdout test risk predictions.
7. Analyze historical follow-up notes using Gemini.
8. Validate AI-generated structured responses.
9. Integrate predictions and insights into RescueDesk.
10. Simulate potential appointment recovery.
11. Perform automated quality-assurance checks.

## Dataset Summary

- Cleaned appointment records: 990
- Clinics: 8
- Historical no-shows: 218
- Machine learning test predictions: 198
- High-risk test flags: 49
- AI follow-up records reviewed: 10
- Validated AI classifications: 9
- Missing follow-up records: 1

## Machine Learning

The project compares multiple classification models,
including Logistic Regression, Decision Tree and
Random Forest.

Model selection uses cross-validation on training data
rather than choosing a model using test-set performance.

The selected model is Logistic Regression.

Historical test predictions are used to demonstrate
risk ranking. Predictions are not guaranteed outcomes.

## Generative AI

Gemini classifies historical follow-up notes into
categories such as:

- Forgot appointment or reminder issue
- Distance or transport difficulty
- Consultation cost
- Illness or emergency
- Work or scheduling conflict
- Other reasons

Pydantic validates the structured AI responses.

Missing follow-up notes remain explicitly unclassified.
AI recommendations require human review.

## CareLoop RescueDesk

The interactive dashboard includes four modules:

### 1. Command Center
Clinic-level appointment metrics and risk distributions.

### 2. Smart Calling Queue
Historical appointments ranked by predicted risk,
with configurable calling capacity.

### 3. Recovery Simulator
Hypothetical estimates using adjustable contact
success, recovery assumptions and visit fees.

### 4. AI Patient Insights
Historical root-cause analysis and recommended
follow-up actions.

## Quality Assurance

- Automated RescueDesk checks: 19
- Passed: 19
- Failed: 0

Additional AI validation tests check malformed,
incomplete and out-of-range AI responses.

## Important Limitations

- Dashboard records come from historical data.
- Recovery estimates are simulations, not observed results.
- Model probabilities may not be perfectly calibrated.
- Post-appointment feedback is not a prediction input.
- AI confidence is not independently verified accuracy.
- Further prospective evaluation is needed before
  operational or clinical use.
- Real patient information requires appropriate
  privacy safeguards and authorization.

## Future Scope

- Integration with live appointment booking software
- Consent-based SMS and WhatsApp reminders
- Actual outreach outcome tracking
- Model calibration and periodic monitoring
- Clinic-specific recovery recommendations
- Experimental measurement of intervention benefits

## Conclusion

CareLoop demonstrates how structured analytics,
predictive models, validated Generative AI and
interactive decision-support tools can be combined
into one healthcare operations prototype.
