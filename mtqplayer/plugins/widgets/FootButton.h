#pragma once

#include <QSvgRenderer>

#include "BaseWidget.h"

class FootButton: public BaseWidget
{
	//Tell the Qt-Preprocessor this is a QObject
	Q_OBJECT

	//Register widget as plugin for use in QML
	MTQ_QML_PLUGIN_REGISTRATION(FootButton, "widgets")

	//QProperties: access attributes from QML.
	//Here we define the getters and setters to be used
	Q_PROPERTY(bool active READ active WRITE setActive NOTIFY activeChanged)
	Q_PROPERTY(QString type READ type WRITE setType)

public:
	FootButton(QQuickItem *parent = 0);

	void paint(QPainter *painter);

	bool active() const;
	void setActive(const bool state);
	QString type();
	void setType(QString type);

private:
	QString m_text;
	bool m_active;
	QString m_type;
	QSvgRenderer *m_svgRenderer;

protected:
	void processTapDown(mtq::TapEvent *event);
	void processTapUp(mtq::TapEvent *event);
	void processTapCancel(mtq::TapEvent *event);

signals:
	void pressed();
	void textChanged(QString text);
	void activeChanged(bool active);

};
