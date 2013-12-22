#include "RectangleButton.h"

#include <QPainter>

#include "Design.h"

using namespace mtq;

//We need to register this Type in MTQ
MTQ_QML_REGISTER_PLUGIN(RectangleButton)

RectangleButton::RectangleButton(QQuickItem *parent)
	: BaseWidget(parent),
	  m_active(false)
{
	setHeight(160);
	setWidth(250);
}

RectangleButton::RectangleButton(QQuickItem *parent, const QColor background)
	: BaseWidget(parent),
	  m_active(false)
{
	setHeight(160);
	setWidth(250);

	setBackground(background);
}

//This is the painting method. It paints the RectangleButton using the QPainter painter
void RectangleButton::paint(QPainter *painter)
{
	int roundedCornerSize = 40;
	if(height() < 80 || width() < 80)
		roundedCornerSize = 0;

	QColor background = m_background;
	if (active())
		background.setAlpha(255);

	// Render Rectangle
	QRectF rect(0, 0, width(), height());
	painter->fillRect(rect, QBrush(background));
	painter->drawRect(0, 0, width(), height());

	// Render caption
	//QRectF rect(0, 0, width(), height());
	//painter->setPen(design::labelFontColor);
	//painter->setFont(design::labelFont);
	//painter->drawText(rect, Qt::AlignCenter , m_text);
}

void RectangleButton::processTapDown(mtq::TapEvent *event)
{
	setActive(true);
	emit pressed();
}

void RectangleButton::processTapUp(mtq::TapEvent *event)
{
	setActive(false);
}

void RectangleButton::processTapCancel(mtq::TapEvent *event)
{
	setActive(false);
}

QColor RectangleButton::background() const
{
	return m_background;
}

void RectangleButton::setBackground(const QColor background)
{
	m_background = background;
	update();
}

bool RectangleButton::active() const
{
	return m_active;
}

void RectangleButton::setActive(const bool state)
{
	m_active = state;
	update();
}
